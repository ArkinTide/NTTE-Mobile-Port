// Release numbering is independent of GAME_BUILD, which belongs to save formats.
#macro NTTE_RELEASE_NUMBER 77
#macro NTTE_RELEASE_TAG "candidate77"
#macro NTTE_RELEASE_VERSION "1.0.2"
#macro NTTE_RELEASE_REPO "https://github.com/ArkinTide/NTTE-Mobile-Port"
#macro NTTE_RELEASE_API "https://api.github.com/repos/ArkinTide/NTTE-Mobile-Port/releases/latest"

function scrNTTEUpdateInit() {
    UberCont.ntte_update={status:"idle",automatic:save_get_option("updates","automatic",UberCont.opt_updates!=0),
        auto_checked:false,boot_at:current_time,request:-1,started_at:0,next_allowed:0,
        release:undefined,pending_prompt:false,notified_tag:"",dialog:-1,dialog_url:"",
        download_id:-1,progress:0,install_pending:false}
}
function scrNTTEUpdateState() {
    if(!variable_instance_exists(UberCont,"ntte_update") || !is_struct(UberCont.ntte_update)) scrNTTEUpdateInit()
    return UberCont.ntte_update
}
function scrNTTEUpdateText(_english,_chinese) {
    return scrNTTEFullIsSimplifiedChinese()?_chinese:_english
}
function scrNTTEUpdateNumber(_tag) {
    if(!is_string(_tag) || string_copy(_tag,1,9)!="candidate") return -1
    var _digits=string_delete(_tag,1,9),_len=string_length(_digits)
    if(_len<1 || _len>7 || (_len>1 && string_char_at(_digits,1)=="0")) return -1
    for(var _i=1;_i<=_len;++_i) {
        var _c=ord(string_char_at(_digits,_i))
        if(_c<48 || _c>57) return -1
    }
    return real(_digits)
}
function scrNTTEUpdateVersionLabel(_release,_fallback) {
    var _name=_release[$ "name"]
    if(!is_string(_name) || string_length(_name)>24) return _fallback
    var _parts=string_split(_name,".")
    if(array_length(_parts)!=3) return _fallback
    for(var _i=0;_i<3;++_i) {
        var _part=_parts[_i],_n=string_length(_part)
        if(_n<1 || _n>7 || (_n>1 && string_char_at(_part,1)=="0")) return _fallback
        for(var _j=1;_j<=_n;++_j) {
            var _c=ord(string_char_at(_part,_j))
            if(_c<48 || _c>57) return _fallback
        }
    }
    return _name
}
function scrNTTEUpdateParse(_body,_platform=os_type) {
    var _bad={status:"failed"}
    if(!is_string(_body) || string_byte_length(_body)>524288) return _bad
    var _release
    try {_release=json_parse(_body)} catch(_error) {return _bad}
    if(!is_struct(_release)) return _bad
    var _tag=_release[$ "tag_name"],_number=scrNTTEUpdateNumber(_tag)
    if(_number<0 || _release[$ "draft"]!=false || _release[$ "prerelease"]!=false) return _bad
    if(_number<=NTTE_RELEASE_NUMBER) return {status:"current",tag:_tag,number:_number}
    var _page=NTTE_RELEASE_REPO+"/releases/tag/"+_tag,
        _result={status:"available",tag:_tag,version:scrNTTEUpdateVersionLabel(_release,_tag),number:_number,page:_page,url:_page,has_installer:false},
        _extension=_platform==os_android?".apk":(_platform==os_ios?".ipa":""),
        _prefix="NuclearThrone.TerritorialExpansion-"+(_platform==os_android?"Android-":"iOS-"),
        _assets=_release[$ "assets"]
    if(_extension=="") return _result
    _result.status="unavailable"
    if(!is_array(_assets) || array_length(_assets)>100) return _result
    for(var _i=0;_i<array_length(_assets);++_i) {
        var _asset=_assets[_i]
        if(!is_struct(_asset)) continue
        var _name=_asset[$ "name"],_url=_asset[$ "browser_download_url"],_size=_asset[$ "size"]
        if(!is_string(_name) || !is_string(_url) || !is_numeric(_size) || _size<=0) continue
        var _suffix="-"+_tag+_extension
        if(string_copy(_name,1,string_length(_prefix))!=_prefix
            || string_copy(_name,string_length(_name)-string_length(_suffix)+1,string_length(_suffix))!=_suffix) continue
        // Only open an exact asset path in this repository; never execute downloaded code.
        var _plain=true
        for(var _j=1;_j<=string_length(_name);++_j) {
            var _c=ord(string_char_at(_name,_j))
            if(!((_c>=48 && _c<=57)||(_c>=65 && _c<=90)||(_c>=97 && _c<=122)||_c==45||_c==46||_c==95)) {_plain=false;break}
        }
        if(!_plain || _url!=NTTE_RELEASE_REPO+"/releases/download/"+_tag+"/"+_name
            || _asset[$ "state"]!="uploaded") continue
        var _digest=_asset[$ "digest"]
        if(_platform==os_android && !scrNTTEUpdateDigestValid(_digest)) continue
        _result.status="available";_result.has_installer=true;_result.url=_url
        _result.bytes=_size;_result.sha256=is_string(_digest)?string_delete(_digest,1,7):""
        return _result
    }
    return _result
}
function scrNTTEUpdateDigestValid(_digest) {
    if(!is_string(_digest) || string_length(_digest)!=71 || string_copy(_digest,1,7)!="sha256:") return false
    var _hex="0123456789abcdef"
    for(var _i=8;_i<=71;++_i) if(string_pos(string_char_at(_digest,_i),_hex)==0) return false
    return true
}
function scrNTTEUpdateCheck(_manual=false) {
    var _s=scrNTTEUpdateState()
    if(_s.status=="downloading" || _s.status=="verifying" || _s.install_pending || _s.dialog>=0) return -1
    if(_s.request>=0) return _s.request
    if(!UberCont.opt_online) {_s.status="offline";return -1}
    if(!_manual && (!_s.automatic || scrNTTESmokeEnabled())) return -1
    if(current_time<_s.next_allowed) return -1
    _s.auto_checked=true;_s.pending_prompt=false;_s.status="checking";_s.release=undefined
    _s.started_at=current_time;_s.next_allowed=current_time+30000
    var _headers=ds_map_create()
    ds_map_add(_headers,"Accept","application/vnd.github+json")
    ds_map_add(_headers,"User-Agent","NTTE-Mobile-Port/"+NTTE_RELEASE_TAG)
    ds_map_add(_headers,"X-GitHub-Api-Version","2022-11-28")
    try {_s.request=scrHttpRequest(NTTE_RELEASE_API,"GET",_headers,"")}
    catch(_error) {_s.request=-1}
    ds_map_destroy(_headers)
    if(_s.request<0) _s.status="failed"
    return _s.request
}
function scrNTTEUpdateHttpEvent(_event) {
    var _s=scrNTTEUpdateState()
    if(_s.request<0 || _event[? "id"]!=_s.request) return false
    var _status=_event[? "status"]
    if(is_numeric(_status) && _status>0) return true // partial download
    _s.request=-1
    var _http=_event[? "http_status"]
    if(_http==403 || _http==429) {
        _s.status="limited";_s.next_allowed=current_time+900000;return true
    }
    if(_http!=200 || (is_numeric(_status) && _status<0)) {_s.status="failed";return true}
    var _result=scrNTTEUpdateParse(_event[? "result"])
    _s.status=_result.status;_s.release=_result
    _s.pending_prompt=_result.status=="available" && _s.notified_tag!=_result.tag
    return true
}
function scrNTTEUpdateCanPrompt() {
    return !os_is_paused() && (instance_exists(MainMenuButton) || instance_exists(Menu))
        && !instance_exists(Logo) && !instance_exists(Player) && !instance_exists(MakeGame)
        && !instance_exists(MenuGen) && !instance_exists(MenuOptions) && !instance_exists(Cinematic)
}
function scrNTTEUpdateTick(_now=current_time) {
    var _s=scrNTTEUpdateState()
    if(_s.request>=0 && _now-_s.started_at>=20000) {
        _s.request=-1;_s.status="failed" // late callbacks are ignored by request ID
    }
}
function scrNTTEUpdateStep() {
    scrNTTEUpdateTick()
    if(scrNTTESmokeEnabled()) return
    var _s=scrNTTEUpdateState()
    if(os_type==os_android && _s.install_pending && !os_is_paused() && !instance_exists(Player)
        && (instance_exists(MainMenuButton) || instance_exists(Menu) || instance_exists(MenuOptions))) {
        if(NTTEUpdateInstall()>=0) _s.install_pending=false
    }
    // One automatic request per launch, delayed until the actual main menu is idle.
    if(!_s.auto_checked && _s.automatic && current_time-_s.boot_at>=5000 && scrNTTEUpdateCanPrompt()) {
        _s.auto_checked=true;scrNTTEUpdateCheck(false)
    }
    if(_s.pending_prompt && _s.dialog<0 && scrNTTEUpdateCanPrompt()) scrNTTEUpdatePrompt()
}
function scrNTTEUpdatePrompt() {
    var _s=scrNTTEUpdateState()
    if(!is_struct(_s.release) || _s.release.status!="available" || _s.dialog>=0) return -1
    var _note=scrNTTEUpdateText("New NTTE version: ","发现 NTTE 新版本：")+_s.release.version+"\n"
        +scrNTTEUpdateText("Installed: ","当前版本：")+NTTE_RELEASE_VERSION+"\n\n"
    if(os_type==os_ios) _note+=scrNTTEUpdateText("Download the IPA? It must be signed again before installation.","是否下载新版 IPA？安装前仍需重新签名。")
    else if(os_type==os_android) _note+=scrNTTEUpdateText("Download the APK in-game and open the system installer? Install over this app to keep your saves.","是否在游戏内下载新版 APK 并打开系统安装界面？请覆盖安装以保留存档。")
    else _note+=scrNTTEUpdateText("Open the release page?","是否打开版本发布页？")
    _s.pending_prompt=false;_s.notified_tag=_s.release.tag;_s.dialog_url=_s.release.url
    _s.dialog=show_question_async(_note)
    return _s.dialog
}
function scrNTTEUpdateDialogTarget(_event) {
    var _s=scrNTTEUpdateState()
    if(_s.dialog<0 || _event[? "id"]!=_s.dialog) return ""
    var _url=_s.dialog_url
    _s.dialog=-1;_s.dialog_url=""
    // Cancel/back/no must not open the browser. The URL was built from validated metadata.
    if(_event[? "status"]!=true || !is_struct(_s.release) || _url!=_s.release.url) return ""
    return _url
}
function scrNTTEUpdateDialogEvent(_event) {
    var _url=scrNTTEUpdateDialogTarget(_event)
    if(_url=="") return
    if(os_type==os_android) scrNTTEUpdateBeginDownload()
    else url_open(_url)
}
function scrNTTEUpdateBeginDownload() {
    if(os_type!=os_android) return false
    var _s=scrNTTEUpdateState(),_r=_s.release
    if(!is_struct(_r) || !_r.has_installer || _s.status=="downloading" || _s.status=="verifying") return false
    _s.download_id=NTTEUpdateDownload(_r.url,_r.sha256,_r.bytes)
    _s.status=_s.download_id<0?"download_failed":"downloading";_s.progress=0
    return _s.download_id>=0
}
function scrNTTEUpdateSocialEvent(_event) {
    if(_event[? "type"]!="ntte_update") return false
    var _s=scrNTTEUpdateState()
    if(_event[? "download_id"]!=_s.download_id || _s.download_id<0) return true
    var _state=_event[? "state"],_allowed=["downloading","verifying","ready","permission","installer","install_failed","download_failed","cancelled"]
    if(array_get_index(_allowed,_state)<0) return true
    _s.status=_state
    if(is_numeric(_event[? "progress"])) _s.progress=clamp(_event[? "progress"],0,100)
    if(_state=="ready") _s.install_pending=true
    if(_state=="cancelled") {_s.status="available";_s.download_id=-1;_s.install_pending=false}
    if(_state=="download_failed") {_s.download_id=-1;_s.install_pending=false}
    return true
}
function scrNTTEUpdateSetAutomatic(_enabled) {
    var _s=scrNTTEUpdateState()
    _s.automatic=(_enabled==true)
    save_set_value("updates","automatic",_s.automatic)
    if(!_s.automatic) _s.pending_prompt=false
    else if(_s.status=="idle") _s.auto_checked=false
    scrSave()
}
function scrNTTEUpdateStatusText() {
    var _s=scrNTTEUpdateState()
    switch(_s.status) {
        case "checking":return scrNTTEUpdateText("Checking...","正在检查……")
        case "current":return scrNTTEUpdateText("Up to date","已是最新版本")
        case "available":return scrNTTEUpdateText("New version: ","发现新版：")+_s.release.version
        case "unavailable":return scrNTTEUpdateText("Installer not published yet","新版安装包尚未上传")
        case "offline":return scrNTTEUpdateText("Online features disabled","在线功能已关闭")
        case "limited":return scrNTTEUpdateText("Please try again later","请求过多，请稍后重试")
        case "failed":return scrNTTEUpdateText("Check failed; try again later","检查失败，请稍后重试")
        case "downloading":return scrNTTEUpdateText("Downloading ","正在下载 ")+string(floor(_s.progress))+"%"
        case "verifying":return scrNTTEUpdateText("Verifying installer...","正在校验安装包……")
        case "ready":return scrNTTEUpdateText("Ready to install","已下载，可以安装")
        case "permission":return scrNTTEUpdateText("Allow installs, then tap INSTALL","允许安装应用后点击安装更新")
        case "installer":return scrNTTEUpdateText("System installer opened","系统安装界面已打开")
        case "install_failed":return scrNTTEUpdateText("Tap INSTALL to retry","点击安装更新重试")
        case "download_failed":return scrNTTEUpdateText("Download failed; tap DOWNLOAD to retry","下载或校验失败，请重新下载")
    }
    return scrNTTEUpdateText("Not checked","尚未检查")
}
function scrNTTEUpdateMenuDefine() {
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE)
    option_list=options[OptionCategory.NTTE]
    scrOptionsMenuCreateElement({type:"category",name:scrNTTEUpdateText("UPDATES","版本更新"),category:OptionCategory.NTTE_Updates})
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Updates)
    scrOptionsMenuCreateElements(
        {name:scrNTTEUpdateText("Installed version","当前版本"),available:false,
            get_value:function(_opt){return NTTE_RELEASE_VERSION}},
        {name:scrNTTEUpdateText("Automatic update checks","自动检查更新"),
            get_value:function(_opt){return scrNTTEUpdateState().automatic?OPTION_ON:OPTION_OFF},
            click:function(_opt){scrNTTEUpdateSetAutomatic(!scrNTTEUpdateState().automatic);return true}},
        {name:scrNTTEUpdateText("CHECK NOW","立即检查更新"),
            click:function(_opt){scrNTTEUpdateCheck(true);return true}},
        {name:scrNTTEUpdateText("Status","检查结果"),available:false,
            get_value:function(_opt){return scrNTTEUpdateStatusText()}},
        {name:scrNTTEUpdateText("DOWNLOAD UPDATE","下载更新"),
            condition:function(_opt){return is_struct(scrNTTEUpdateState().release) && array_get_index(["available","download_failed"],scrNTTEUpdateState().status)>=0},
            click:function(_opt){scrNTTEUpdatePrompt();return true}},
        {name:scrNTTEUpdateText("RELEASE HISTORY","历史版本"),
            click:function(_opt){url_open(NTTE_RELEASE_REPO+"/releases");return true}},
        {name:scrNTTEUpdateText("INSTALL UPDATE","安装更新"),
            condition:function(_opt){return os_type==os_android && array_get_index(["ready","permission","installer","install_failed"],scrNTTEUpdateState().status)>=0},
            click:function(_opt){if(os_type==os_android) NTTEUpdateInstall();return true}},
        {name:scrNTTEUpdateText("CANCEL DOWNLOAD","取消下载"),
            condition:function(_opt){return os_type==os_android && array_get_index(["downloading","verifying"],scrNTTEUpdateState().status)>=0},
            click:function(_opt){if(os_type==os_android) NTTEUpdateCancel();return true}})
    if(os_type==os_ios) scrOptionsMenuCreateElement({name:scrNTTEUpdateText("New IPAs require signing before installation.","新版 IPA 安装前需要重新签名。"),available:false,value:""})
    scrOptionsMenuCategoryEnd()
}
