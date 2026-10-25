function scrNTTEUpdateTestRelease(_number=NTTE_RELEASE_NUMBER+1) {
    var _tag="candidate"+string(_number),_assets=[]
    var _platforms=[["Android","apk"],["iOS","ipa"]]
    for(var _i=0;_i<2;++_i) {
        var _name="NuclearThrone.TerritorialExpansion-"+_platforms[_i][0]+"-crashfix-"+_tag+"."+_platforms[_i][1]
        array_push(_assets,{name:_name,browser_download_url:NTTE_RELEASE_REPO+"/releases/download/"+_tag+"/"+_name,size:100,state:"uploaded",digest:"sha256:"+string_repeat("0",64)})
    }
    return {tag_name:_tag,draft:false,prerelease:false,assets:_assets}
}
function scrNTTEUpdateTests() {
    var _old=UberCont.ntte_update,_online=UberCont.opt_online,_bytes=ds_map_write(UberCont.saveData),
        _event=ds_map_create(),_menu=noone,_before=scrNTTEFullInstances(all),
        _language=global.language_current,_parked=scrNTTEFullInstances([MenuOptions,BackButton]),
        _seed=random_get_seed(),_progress=global.ntte_full_progress,
        _reminders=variable_global_exists("ntte_full_reminders")?global.ntte_full_reminders:undefined
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        assert(scrNTTEUpdateNumber(NTTE_RELEASE_TAG)==NTTE_RELEASE_NUMBER,"Installed release number/tag mismatch")
        var _invalid=[undefined,42,"","candidate","candidate-1","candidate075","candidate75x","candidate75/","v75","candidate7.5"]
        for(var _i=0;_i<array_length(_invalid);++_i) assert(scrNTTEUpdateNumber(_invalid[_i])==-1,"Invalid release tag accepted")
        assert(scrNTTEUpdateNumber("candidate100")>scrNTTEUpdateNumber("candidate99"),"Release comparison used lexical order")
        var _release=scrNTTEUpdateTestRelease(),_body=json_stringify(_release),
            _android=scrNTTEUpdateParse(_body,os_android),_ios=scrNTTEUpdateParse(_body,os_ios)
        assert(_android.status=="available" && _ios.status=="available" && _android.has_installer && _ios.has_installer,
            "Paired platform release metadata did not select installers")
        assert(scrNTTEUpdateDigestValid("sha256:"+string_repeat("0",64)) && !scrNTTEUpdateDigestValid("sha256:abc"),"APK hash metadata was not validated")
        assert(string_pos("Android-",_android.url)>0 && string_pos("iOS-",_ios.url)>0,"Wrong platform installer selected")
        var _official=scrNTTEUpdateTestRelease()
        _official.name="1.0.1"
        assert(scrNTTEUpdateParse(json_stringify(_official),os_android).version=="1.0.1",
            "Official semantic version was replaced by an internal serial")
        _official.name="1.0.1\nother text"
        assert(scrNTTEUpdateParse(json_stringify(_official),os_android).version==_official.tag_name,
            "Malformed release title reached the update dialog")
        for(var _n=NTTE_RELEASE_NUMBER-1;_n<=NTTE_RELEASE_NUMBER;++_n) assert(scrNTTEUpdateParse(json_stringify(scrNTTEUpdateTestRelease(_n))).status=="current","Same/old release prompted a downgrade")
        _release.prerelease=true
        assert(scrNTTEUpdateParse(json_stringify(_release)).status=="failed","Prerelease accepted as stable")
        _release.prerelease=false;_release.draft=true
        assert(scrNTTEUpdateParse(json_stringify(_release)).status=="failed","Draft accepted as published")
        for(var _i=0;_i<4;++_i) {
            _release=scrNTTEUpdateTestRelease()
            if(_i==0) _release.assets[0].browser_download_url="https://example.com/other.apk"
            if(_i==1) _release.assets[0].name="../candidate75.apk"
            if(_i==2) _release.assets[0].state="new"
            if(_i==3) _release.assets[0].size=0
            assert(scrNTTEUpdateParse(json_stringify(_release),os_android).status=="unavailable","Unpublished/foreign/malformed asset accepted")
            assert(scrNTTEUpdateParse(json_stringify(_release),os_ios).status=="available","Invalid Android metadata hid valid iOS asset")
        }
        _release.assets=[]
        assert(scrNTTEUpdateParse(json_stringify(_release),os_ios).status=="unavailable","Missing installer accepted")
        var _bad_json=["", "<html>error</html>","[]","{}","null","123"]
        for(var _i=0;_i<array_length(_bad_json);++_i) assert(scrNTTEUpdateParse(_bad_json[_i]).status=="failed","Malformed API response accepted")

        scrNTTEUpdateInit()
        var _s=scrNTTEUpdateState()
        _s.request=74001;_s.status="checking";_s.started_at=100
        ds_map_add(_event,"id",74000);ds_map_add(_event,"status",0);ds_map_add(_event,"http_status",200);ds_map_add(_event,"result",_body)
        assert(!scrNTTEUpdateHttpEvent(_event) && _s.request==74001,"Unrelated async request consumed")
        _event[? "id"]=74001;_event[? "status"]=1
        assert(scrNTTEUpdateHttpEvent(_event) && _s.request==74001 && _s.status=="checking","Partial HTTP callback completed early")
        _event[? "status"]=0
        assert(scrNTTEUpdateHttpEvent(_event) && _s.status=="available" && _s.request==-1 && _s.pending_prompt,"Completed update callback lost latest release")
        _s.notified_tag=_release.tag_name;_s.request=74002;_event[? "id"]=74002
        scrNTTEUpdateHttpEvent(_event)
        assert(!_s.pending_prompt,"Same release notified twice in one launch")
        _s.request=74003;_s.started_at=100;_s.status="checking"
        scrNTTEUpdateTick(20099);assert(_s.request==74003,"Timeout occurred too early")
        scrNTTEUpdateTick(20100);assert(_s.request==-1 && _s.status=="failed","HTTP timeout did not release updater")
        _event[? "id"]=74003
        assert(!scrNTTEUpdateHttpEvent(_event) && _s.status=="failed","Late timeout callback resurrected stale release")
        _s.request=74004;_event[? "id"]=74004;_event[? "http_status"]=429
        scrNTTEUpdateHttpEvent(_event)
        assert(_s.status=="limited" && _s.next_allowed>=current_time+899000,"API rate limit did not back off")
        _s.request=74005;_event[? "id"]=74005;_event[? "http_status"]=200;_event[? "result"]="{"
        scrNTTEUpdateHttpEvent(_event)
        assert(_s.status=="failed","Broken JSON escaped the async handler")
        _s.request=74006;_event[? "id"]=74006;_event[? "http_status"]=0;_event[? "status"]=-1
        scrNTTEUpdateHttpEvent(_event);assert(_s.status=="failed","Transport failure not shown")

        _s.release=_android;_s.dialog=74100;_s.dialog_url=_android.url
        _event[? "id"]=74101;_event[? "status"]=true
        assert(scrNTTEUpdateDialogTarget(_event)=="" && _s.dialog==74100,"Unrelated dialog opened download")
        _event[? "id"]=74100;_event[? "status"]=false
        assert(scrNTTEUpdateDialogTarget(_event)=="" && _s.dialog==-1,"Declining update opened browser")
        _s.dialog=74100;_s.dialog_url=_android.url;_event[? "status"]=true
        assert(scrNTTEUpdateDialogTarget(_event)==_android.url && _s.dialog==-1,"Confirmed dialog lost platform download")
        _s.dialog=74100;_s.dialog_url="https://example.com/other.apk"
        assert(scrNTTEUpdateDialogTarget(_event)=="","Changed dialog URL accepted")
        assert(!scrNTTEUpdateCanPrompt(),"Updater attempted to interrupt an active run")
        UberCont.opt_online=false;_s.request=-1
        assert(scrNTTEUpdateCheck(true)==-1 && _s.status=="offline","Disabled online mode made a request")
        UberCont.opt_online=true;_s.automatic=false;_s.status="idle"
        assert(scrNTTEUpdateCheck(false)==-1 && _s.status=="idle","Disabled automatic checks made a request")
        _s.request=74999
        assert(scrNTTEUpdateCheck(true)==74999,"Concurrent check started another request")
        _s.request=-1;_s.next_allowed=current_time+10000
        assert(scrNTTEUpdateCheck(true)==-1,"Manual request spam bypassed cooldown")
        _s.download_id=74800;_event[? "type"]="ntte_update";_event[? "download_id"]=74801;_event[? "state"]="ready"
        _s.status="available";_s.install_pending=false
        assert(scrNTTEUpdateSocialEvent(_event) && !_s.install_pending,"Stale download callback installed a different job")
        _event[? "download_id"]=74800;_event[? "state"]="downloading";_event[? "progress"]=54
        assert(scrNTTEUpdateSocialEvent(_event) && _s.status=="downloading" && _s.progress==54,"Native download progress lost")
        assert(scrNTTEUpdateCheck(true)==-1,"Update check replaced an active APK download")
        _event[? "state"]="ready";scrNTTEUpdateSocialEvent(_event)
        assert(_s.install_pending && _s.status=="ready","Verified native download did not schedule installation")
        _event[? "state"]="cancelled";scrNTTEUpdateSocialEvent(_event)
        assert(_s.status=="available" && _s.download_id==-1 && !_s.install_pending,"Cancelled download did not allow retry")
        _s.status="available";_s.release=_ios

        _menu=instance_create(0,0,MenuOptions)
        var _rows=_menu.options[OptionCategory.NTTE_Updates]
        assert(array_length(_rows)>=6,"Actual native menu omitted updates page")
        assert(method_execute(_rows[0].get_value,_rows[0])==NTTE_RELEASE_VERSION,"Native installed-version row is empty")
        assert(method_execute(_rows[4].condition,_rows[4]),"Native download row hid a valid release")
        for(var _lang=0;_lang<2;++_lang) {
            global.language_current={}
            global.language_current[$ "Init:Id"]=_lang==0?"English":"Simplified Chinese"
            with(_menu) {event_user(10);scrOptionsMenuChangeCategory(OptionCategory.NTTE_Updates,false)}
            _rows=_menu.options[OptionCategory.NTTE_Updates]
            assert(string_pos(_lang==0?"Installed":"当前",_rows[0].name)>0,"Native update menu language incorrect")
            assert(string_pos(_ios.tag,method_execute(_rows[3].get_value,_rows[3]))>0,"Native status row lost release tag")
        }
        scrNTTESmokeLog("PASS UPDATE CHECK native menus/JSON, platform selection/no downgrade, unrelated+partial+late HTTP, timeout/backoff, cancel/confirm dialogs, offline/preference/concurrency/cooldown and EN/ZH labels @"+string(30/timescale))
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        UberCont.ntte_update=_old;UberCont.opt_online=_online;global.language_current=_language
        global.ntte_full_progress=_progress;global.ntte_full_reminders=_reminders
        random_set_seed(_seed);ds_map_destroy(_event)
        assert(ds_map_write(UberCont.saveData)==_bytes,"Update tests changed the user's save map")
    }
}
