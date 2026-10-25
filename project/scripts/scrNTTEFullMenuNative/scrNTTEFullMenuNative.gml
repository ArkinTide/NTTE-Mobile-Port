// Original temenu model on Epsilon's native touch/controller/scrolling widgets.
// No second input layer: back navigation and game pause remain native.
function scrNTTEFullOptionRaw(_name) {
    return scrNTTEFullLoadoutGet("option:"+_name,
        (_name=="intros" || string_pos("outline:",_name)==1)?2:1);
}
function scrNTTEFullOptionGet(_name) {
    var _value=scrNTTEFullOptionRaw(_name)
    if(_name=="intros" && _value>=2) return UberCont.opt_bossintro;
    if(string_pos("outline:",_name)==1 && _value>=2) {
        var _local=noone
        with(Player) if(scr_player_is_local(index)) {_local=id;break;}
        return scrNTTEFullPlayerActive(_local) && instance_exists(CoopController) && UberCont.opt_outlines;
    }
    if(string_pos("quality:",_name)==1) return lerp(1/3,scrNTTEFullSourceDisplayScale(),_value);
    return _value;
}
function scrNTTEFullOptionSet(_name,_value) {
    if(string_pos("quality:",_name)==1) _value=clamp(_value,0,1)
    else if(_name=="intros" || string_pos("outline:",_name)==1) _value=clamp(round(_value),0,2)
    else _value=!!_value
    scrNTTEFullLoadoutSet("option:"+_name,_value)
    return _value;
}
function scrNTTEFullMenuRemindersEnsure() {
    if(variable_global_exists("ntte_full_reminders") && is_array(global.ntte_full_reminders)) return;
    var _enabled=scrNTTEFullOptionGet("reminders"),_intro=UberCont.opt_bossintro
    // teassets2854: the music reminder deliberately shares the original
    // !bossintros initial condition, rather than guessing from audio volume.
    global.ntte_full_reminders=[
        {active:_enabled && !_intro && scrNTTEFullOptionRaw("intros")>=2
            && !scrNTTEFullLoadoutGet("reminder:bossintro:seen",false),time:0,text:"Turn em on!",key:"reminder:bossintro:seen"},
        {active:_enabled && !_intro && !scrNTTEFullLoadoutGet("reminder:music:seen",false),
            time:0,text:"Pump it up!",key:"reminder:music:seen"}]
}
function scrNTTEFullMenuReminderTick(_reminder,_target) {
    if(!scrNTTEFullOptionGet("reminders") || !_reminder.active) return false;
    if(!_target) {_reminder.time=20;return false;}
    if(_reminder.time<=0) return false;
    _reminder.time-=timescale
    if(_reminder.time<=0) {
        _reminder.active=false
        // Remember the completed guide across process restarts. The existing
        // safe NTTE progress writer runs once at dismissal, never every draw.
        if(is_string(_reminder[$ "key"])) scrNTTEFullLoadoutSet(_reminder.key,true)
        return true;
    }
    return false;
}
function scrNTTEFullMenuReminderDraw(_opt) {
    var _r=global.ntte_full_reminders[_opt.ntte_reminder]
    if(!scrNTTEFullOptionGet("reminders") || !_r.active) return false;
    if(scrNTTEFullMenuReminderTick(_r,_opt.ntte_reminder_target)) {
        var _popup=instance_create(view_xview+drawx-_opt.width/2-8,view_yview+drawy,PopupText)
        _popup.mytext=_r.text;_popup.ntte_translate=true;_popup.friction=0.1*timescale*timescale
    }
    else draw_sprite(sprNew,0,drawx-_opt.width/2-8,drawy+sin(current_frame/10))
    return false;
}
function scrNTTEFullMenuRemindersBind() {
    scrNTTEFullMenuRemindersEnsure()
    var _pages=[[OptionCategory.Main,0],[OptionCategory.Game,0],[OptionCategory.Audio,1]]
    for(var _p=0;_p<array_length(_pages);++_p) {
        var _page=_pages[_p][0],_rows=options[_page]
        for(var _i=0;_i<array_length(_rows);++_i) {
            var _row=_rows[_i],_which=-1,_target=false
            if(_page==OptionCategory.Main) {
                if(_row.category==OptionCategory.Game) _which=0
                else if(_row.category==OptionCategory.Audio) _which=1
            }
            else if((_page==OptionCategory.Game && _row.key=="visual_bossintro")
                || (_page==OptionCategory.Audio && _row.key=="volume_music")) {
                _which=_pages[_p][1];_target=true
            }
            if(_which>=0) {
                assert(is_undefined(_row.draw),"Native reminder row already has a custom renderer")
                _row.ntte_reminder=_which;_row.ntte_reminder_target=_target
                _row.draw=method(id,scrNTTEFullMenuReminderDraw)
            }
        }
    }
}
function scrNTTEFullMenuTime(_seconds) {
    _seconds=max(0,floor(_seconds))
    var _minutes=(_seconds div 60) mod 60,_remainder=_seconds mod 60
    return string(_seconds div 3600)+":"+(_minutes<10?"0":"")+string(_minutes)
        +":"+(_remainder<10?"0":"")+string(_remainder);
}
function scrNTTEFullMenuStatText(_key,_kind="number") {
    return scrNTTEFullMenuPresentationStatText(_key,_kind);
}
function scrNTTEFullMenuRow(_label,_key,_kind="number") {
    scrOptionsMenuCreateElement({name:_label,ntte_stat:_key,ntte_kind:_kind,available:false,
        get_value:function(_opt){return scrNTTEFullMenuStatText(_opt.ntte_stat,_opt.ntte_kind)}})
}
function scrNTTEFullMenuPetValue(_pet,_key) {
    return scrNTTEFullMenuPresentationPetValue(_pet,_key);
}
function scrNTTEFullMenuPets() {
    return ["Scorpion","Parrot","Slaughter","CoolGuy","Salamander","Mimic","Octo","Spider","Prism","Orchid","Weapon","Twins","Cuz","Guardian"];
}
function scrNTTEFullMenuPetKnown(_pet) {
    var _stat=scrNTTEFullValue(global.ntte_full_progress.stats,"pet:"+_pet+".petlib.mod",{})
    return scrNTTEFullValue(_stat,"found",0)>0 || scrNTTEFullValue(_stat,"owned",0)>0;
}
function scrNTTEFullMenuPetPage(_pet) {
    return scrNTTEFullMenuPresentationPetPage(_pet);
}
function scrNTTEFullMenuCreditDraw(_opt) {
    var _lines=string_split(string_hash_to_newline(_opt.name),"\n"),
        _line_height=font_get_string_height("A"),_ha=draw_get_halign(),_va=draw_get_valign()
    draw_align(fa_center,fa_top)
    // The native list advances by the current row's full height. Use its
    // leading edge, rather than centering a long block against the next row.
    // Clip individual lines away from the fixed title/back-button region.
    for(var _i=0;_i<array_length(_lines);++_i) {
        var _y=drawy+_i*_line_height
        if(_y>=max(LETTERBOX_SIZE+32,40) && _y+_line_height<=gui_h-LETTERBOX_SIZE-8)
            // The split already unescaped Discord's literal hash. Escape it
            // again for draw_text_nt's own hash-to-newline conversion.
            draw_text_nt(drawx,_y,string_replace_all(_lines[_i],"#","\\#"))
    }
    draw_align(_ha,_va)
    return true
}
function scrNTTEFullMenuDefine() {
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    var _old=option_number
    scrOptionsMenuCategoryBegin(OptionCategory.Main)
    option_list=options[OptionCategory.Main]
    scrOptionsMenuCreateElement({type:"category",name:"NT:TE",category:OptionCategory.NTTE})
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE)
    scrOptionsMenuCreateElements(
        {type:"category",name:"OPTIONS",category:OptionCategory.NTTE_Options},
        {type:"category",name:"STATS",category:OptionCategory.NTTE_Stats},
        {type:"category",name:"CREDITS",category:OptionCategory.NTTE_Credits},
        {type:"category",name:"MUTANTS",category:OptionCategory.NTTE_Mutants,visible:false},
        {type:"category",name:"PETS",category:OptionCategory.NTTE_Pets,visible:false},
        {type:"category",name:"UNLOCKS",category:OptionCategory.NTTE_Unlocks,visible:false},
        {type:"button",name:"PET",visible:false,category:OptionCategory.NTTE_PetDetails,
            get_name:function(_opt){return scrNTTEFullValue(id,"ntte_menu_pet","PET")}})
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Options)
    var _options=[["Use Shaders","shaders",2],["Reminders","reminders",2],["Footprints","footprints",2],
        ["NTTE Intros","intros",3],["Pets Outline","outline:pets",3],["Charm Outline","outline:charm",3],
        ["Visual Quality: Main","quality:main",0],["Visual Quality: Minor","quality:minor",0]]
    for(var _i=0;_i<array_length(_options);++_i) {
        var _row=_options[_i],_slider=_row[2]==0
        scrOptionsMenuCreateElement({type:_slider?"slider":"button",name:_row[0],ntte_option:_row[1],
            ntte_states:_row[2],value:scrNTTEFullOptionRaw(_row[1]),
            awake:function(_opt){_opt.value=scrNTTEFullOptionRaw(_opt.ntte_option)},
            get_value:function(_opt){
                return _opt.ntte_states==0?_opt.value:(_opt.value==2?"AUTO":(_opt.value?"ON":"OFF"));
            },
            click:function(_opt){
                if(_opt.ntte_states!=0) _opt.value=(_opt.value+1) mod _opt.ntte_states
                scrNTTEFullOptionSet(_opt.ntte_option,_opt.value)
                return true;
            }})
    }
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Stats)
    scrOptionsMenuCreateElements(
        {type:"category",name:"MUTANTS",category:OptionCategory.NTTE_Mutants},
        {type:"category",name:"PETS",category:OptionCategory.NTTE_Pets},
        {type:"category",name:"UNLOCKS",category:OptionCategory.NTTE_Unlocks})
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Mutants)
    for(var _r=0;_r<2;++_r) {
        var _race=_r==0?"beetle":"parrot",_path="race:"+_race+":"
        scrOptionsMenuCreateElement({name:string_upper(_race),available:false,value:""})
        var _fields=[["Kills","kill"],["Loops","loop"],["Runs","runs"],["Deaths","lost"],["Wins","wins"],["Time","time"]]
        for(var _i=0;_i<array_length(_fields);++_i)
            scrNTTEFullMenuRow(_fields[_i][0],_path+_fields[_i][1],_fields[_i][1]=="time"?"time":"number")
        scrNTTEFullMenuRow(_r==0?"Spent":"Charmed",_path+"spec")
        scrNTTEFullMenuRow("Best Area",_path+"best:area","area")
        scrNTTEFullMenuRow("Best Kills",_path+"best:kill")
    }
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Pets)
    var _pets=scrNTTEFullMenuPets()
    for(var _i=0;_i<array_length(_pets);++_i) {
        var _pet=_pets[_i]
        scrOptionsMenuCreateElement({name:string_upper(_pet),ntte_pet:_pet,
            condition:function(_opt){return scrNTTEFullMenuPetKnown(_opt.ntte_pet);},
            get_name:function(_opt){
                return scrNTTEFullMenuPetKnown(_opt.ntte_pet)?string_upper(_opt.ntte_pet):"UNKNOWN";
            },
            click:function(_opt){scrNTTEFullMenuPetPage(_opt.ntte_pet);return true;}})
    }
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_PetDetails)
    scrOptionsMenuCreateElement({name:"NONE",available:false})
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Unlocks)
    var _packs=["coast","oasis","trench","lair","red","crown"]
    for(var _i=0;_i<array_length(_packs);++_i) {
        scrOptionsMenuCreateElement({name:string_upper(_packs[_i]),ntte_unlock:"pack:"+_packs[_i],available:false,
            get_value:function(_opt){return scrNTTEFullUnlockGet(_opt.ntte_unlock)?"UNLOCKED":"LOCKED";}})
    }
    scrNTTEFullMenuRow("Time","time","time");scrNTTEFullMenuRow("Bones","bone")
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_Credits)
    var _credits=[["Yokin","Lead Programmer#Twitter: Yokinman#Discord: Yokin\\#1322"],
        ["THX","Sprite Artist#Twitter: thxsprites#Discord: THX\\#0011"],
        ["matt","Sprite Artist / Programmer#Twitter: attfooy#Discord: attfooy\\#5026"],
        ["peas","Sprite Artist#Twitter: realestpeas#Discord: peas\\#8304"],
        ["jsburg","Programmer?#Itch.io: jsburg#Discord: Jsburg\\#1045"],
        ["karmelyth","Weapon Sprites / Programming#Twitter: karmelyth#Discord: Karmelyth\\#7168"],
        ["RENREN","Music#Twitter: MistaJub#Bandcamp: mistajub#Discord: RENREN\\#8521"],
        ["Wildebee","Sound Design / Programmer#Trailers#Twitter: Wilde_bee#Discord: Wildebee\\#6521"],
        ["Special Thanks","kuzumi#Golden vegetable#Dinosaur leader#blaac / jordy / Emffles / minichibis#Twitter: blaac_ / akimokawa#EmfflesTWO / minichibisart"],
        ["iOS port","ArkinTide"]]
    for(var _i=0;_i<array_length(_credits);++_i) {
        var _text=_credits[_i][0]+"#"+_credits[_i][1]
        // Measure the final text, including all added names, before native
        // scrolling lays out the rows. Post-build string replacement left
        // these extra lines outside the old height and overlapped the row below.
        scrOptionsMenuCreateElement({name:_text,available:false,width:300,value:"",
            height:font_get_string_height(string_hash_to_newline(_text))+12,
            draw:method(id,scrNTTEFullMenuCreditDraw)})
    }
    scrOptionsMenuCategoryEnd()
    // BEGIN NTTE PET MENU PRESENTATION
    scrNTTEFullMenuPetPresentationBind();
    // END NTTE PET MENU PRESENTATION
    scrNTTEFullMenuRemindersBind()
    scrNTTEUpdateMenuDefine()
    option_number=_old
}
