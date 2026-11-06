// telib.mod.gml:422 and6307: aggregate during this frame, sleep once at
// the beginning of the next frame, before authored BeginStep callbacks.
function scrNTTEFullFrameSleepRequest(_milliseconds) {
    GameCont.ntte_full_sleep_max=max(scrNTTEFullValue(GameCont,"ntte_full_sleep_max",0),_milliseconds)
}
function scrNTTEFullFrameSleepConsume(_perform=true) {
    var _milliseconds=scrNTTEFullValue(GameCont,"ntte_full_sleep_max",0)
    if(_milliseconds>0) {
        if(_perform) sleep(_milliseconds)
        GameCont.ntte_full_sleep_max=0
    }
    return _milliseconds
}
// game_scale_nonsync is screen width divided by logical game width. The
// native mobile renderer uses its configured logical view in a full-width
// output window; opt_scaling changes render-surface resolution separately.
function scrNTTEFullSourceDisplayScale(_physicalWidth=undefined,_logicalWidth=undefined) {
    if(is_undefined(_physicalWidth)) _physicalWidth=window_get_width()
    if(is_undefined(_logicalWidth)) _logicalWidth=view_width
    return _logicalWidth>0 && _physicalWidth>0 ? _physicalWidth/_logicalWidth:1
}
function scrNTTEFullSourceRuntimeNativeTests() {
    var _pending=scrNTTEFullValue(GameCont,"ntte_full_sleep_max",0)
    try {
        GameCont.ntte_full_sleep_max=0
        scrNTTEFullFrameSleepRequest(5);scrNTTEFullFrameSleepRequest(15);scrNTTEFullFrameSleepRequest(10)
        assert(GameCont.ntte_full_sleep_max==15,"Source sleep_max stacked simultaneous strikes")
        assert(scrNTTEFullFrameSleepConsume(false)==15 && GameCont.ntte_full_sleep_max==0
            && scrNTTEFullFrameSleepConsume(false)==0,"Source sleep_max did not consume/reset exactly once")
        scrNTTEFullFrameSleepRequest(1)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(GameCont.ntte_full_sleep_max==0,"Actual BeginStep did not consume queued source sleep")
        assert(scrNTTEFullSourceDisplayScale(640,320)==2 && scrNTTEFullSourceDisplayScale(160,320)==0.5
            && scrNTTEFullSourceDisplayScale()>0,
            "Source display scale used render-surface scaling or invented a minimum of one")
    }
    finally {GameCont.ntte_full_sleep_max=_pending}
    scrNTTESmokeLog("FULL SOURCE RUNTIME: nonstacking sleep_max/next actual BeginStep/once-only reset and floating screen-to-logical display scale OK")
}
