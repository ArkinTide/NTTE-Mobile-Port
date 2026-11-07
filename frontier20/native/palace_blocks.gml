// Crush Trap's collision wall moves with its projectile body. It is not a
// duplicate level-generation tile and must survive overlap with other walls.
function scrFRPalaceBlockProxy(_wall) {
    return instance_exists(_wall) && (_wall[$ "fr_palace_block_proxy"]??false);
}

function scrFRPalaceBlockWallPair(_a,_b) {
    return scrFRPalaceBlockProxy(_a) || scrFRPalaceBlockProxy(_b);
}

function scrFRPalaceSmushStep() {
    // The upstream one-tick impact is born inside a Collision event. Its
    // coroutine wait can resume in the host Step before a new projectile has
    // received its first native Collision phase. Own only this impact's
    // lifetime in End Step, after its real native collision opportunity.
    return self[$ "fr_palace_smush"]??false;
}

function scrFRPalaceSmushHit() {
    var _target=scrFROther(other);
    if(!instance_exists(_target)) return;
    var _key=string(real(_target.id));
    // One authored source tick can span two host Collision phases at60Hz.
    // Apply its actual on_hit once per victim, preserving the source's
    // player/enemy damage choice and the block's reverse-on-crush behavior.
    if(fr_palace_smush_targets[$ _key]??false) return;
    fr_palace_smush_targets[$ _key]=true;
    var _before=_target[$ "hp"]??0;
    scrFRInvoke(id,fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_hit,[]);
    if(os_type==os_windows && scrNTTEFullSmokeEnabled())
        scrFRPalaceBlockTestsSmushHit(id,_target,_before);
}

function scrFRPalaceBlockEndStep() {
    if(self[$ "fr_palace_smush"]??false) {
        if(!lockstep_stop) {
            // Do not count the partial Collision-to-End-Step birth frame as
            // a source tick. All later aging happens after native Collision.
            if(fr_palace_smush_age<0) fr_palace_smush_age=0;
            else {
                fr_palace_smush_age+=timescale;
                if(fr_palace_smush_age>=1) instance_destroy();
            }
        }
        return true;
    }
    if((self[$ "name"]??"")!="fr_CrushBlock") return false;
    // Its authored End Step applies native, already scaled hspeed_raw and
    // synchronizes a solid proxy. Run that physical bookkeeping on every host
    // frame; only the AI/cooldowns/cosmetics remain on the source 30 Hz clock.
    if(!lockstep_stop) {
        scrFRActorCallback("on_end_step");
        // The source synchronizes mywall before its final inactive grid snap.
        // After a wall impact the body therefore ends at the snapped point
        // while its collision wall remains at the preceding physical point.
        // Bind the proxy to the completed body position, after that authored
        // snap as well as on every 60 Hz host movement frame.
        if(instance_exists(mywall)) {
            mywall.x=x;mywall.y=y;
            mywall.xprevious=x;mywall.yprevious=y;
        }
        if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrFRPalaceBlockTestsObserve(id);
    }
    return true;
}
