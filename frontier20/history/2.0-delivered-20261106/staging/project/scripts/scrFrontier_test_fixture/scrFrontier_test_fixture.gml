function fr_tests_frontier_gml___load() {

}

function fr_tests_frontier_gml_values(_frl__items=undefined) {
var _frl_result = [];
;
{ var __fr_with1 = scrFRWithValues(_frl__items), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
array_push(_frl_result, scrFRSelf(self));
}
if(__fr_break3) break;
}}
;
return _frl_result;
;
}

function fr_tests_frontier_gml_ref_sum(_frl__a=undefined, _frl__b=undefined, _frl__c=undefined) {
return ((_frl__a + (10 * _frl__b)) + (100 * _frl__c));
;
}

function fr_tests_frontier_gml_template(_frl__path=undefined) {
return ("" + string(_frl__path) + "sprPopoLaserBrain.png @1(" + string((1 + 2)) + ":0)");
;
}

function fr_tests_frontier_gml_instance_array(_frl__items=undefined) {
{ var __fr_with1 = scrFRWithValues(_frl__items), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
fr_array_probe += 3;
}
if(__fr_break3) break;
}}
;
}

function fr_tests_frontier_gml_bound_ref() {
return scrFRScriptCall(["mod", "frontier.gml", fr_tests_frontier_gml_ref_sum, 2, 3], 4);
;
}

function fr_tests_frontier_gml_coroutine() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_tests_frontier_gml_coroutine_resume, id, scrFROther(other), _args, 9, []);
}
function fr_tests_frontier_gml_coroutine_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_tests_frontier_gml_coroutine");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // tests/frontier.gml:26
{
;
value += 2;
;
}
_fr.pc=0;
break;
case 2: // tests/frontier.gml:26
_fr.wait_ticks=max(0,1); _fr.pc=1; return;
break;
case 3: // tests/frontier.gml:25
{
value += 1;
;
}
_fr.pc=2;
break;
case 4: // tests/frontier.gml:23
{
;
}
_fr.pc=3;
break;
case 5: // tests/frontier.gml:23
_fr.result=undefined; _fr.done=true; return;
break;
case 6: // tests/frontier.gml:21
{
;
value += 10;
;
}
_fr.pc=5;
break;
case 7: // tests/frontier.gml:21
_fr.wait_ticks=max(0,2); _fr.pc=6; return;
break;
case 8: // tests/frontier.gml:20
_fr.pc = (scrFRTaskFork(_fr, 7)) ? 7 : 3;
break;
case 9: // tests/frontier.gml:19
{
value = 0;
;
}
_fr.pc=8;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


function fr_tests_frontier_gml_cleanup_coroutine() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_tests_frontier_gml_cleanup_coroutine_resume, id, scrFROther(other), _args, 7, []);
}
function fr_tests_frontier_gml_cleanup_coroutine_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_tests_frontier_gml_cleanup_coroutine");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // tests/frontier.gml:35
{
;
}
_fr.pc=0;
break;
case 2: // tests/frontier.gml:35
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // tests/frontier.gml:33
{
;
GameCont.fr_cleanup_fork_test = (cleanup_value + 1);
;
}
_fr.pc=2;
break;
case 4: // tests/frontier.gml:33
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 5: // tests/frontier.gml:32
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 0;
break;
case 6: // tests/frontier.gml:30
{
;
GameCont.fr_cleanup_test = cleanup_value;
;
}
_fr.pc=5;
break;
case 7: // tests/frontier.gml:30
_fr.wait_ticks=max(0,2); _fr.pc=6; return;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


function fr_tests_frontier_gml_dynamic_case(_frl__value=undefined) {
var _frl_answer = 0;
;
{ var __fr_switch_value1=_frl__value, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(array_get([2, 7], 0))) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(array_get([2, 7], 1))) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(8)) __fr_switch_case2=3;
if(__fr_switch_case2==-1) __fr_switch_case2=2;
switch(__fr_switch_case2) {
case 0:

case 1:
_frl_answer += 10;
;
case 2:
_frl_answer += 3;
;
break;
;
case 3:
_frl_answer = 88;
;
break;
;
}
}
return _frl_answer;
;
}

function fr_tests_frontier_gml_raw_motion_read(_frl__target=undefined) {
return [hspeed, vspeed, image_speed, (hspeed / timescale), (vspeed / timescale), (image_speed / timescale), _frl__target.hspeed, _frl__target.vspeed, _frl__target.image_speed, scrFRVariableGet(_frl__target, "hspeed_raw"), scrFRVariableGet(_frl__target, "vspeed_raw"), scrFRVariableGet(_frl__target, "image_speed_raw"), scrFRVariableGet(_frl__target, "hspeed"), scrFRVariableGet(_frl__target, "vspeed"), scrFRVariableGet(_frl__target, "image_speed"), scrFRSelf(self), _frl__target];
;
}

function fr_tests_frontier_gml_raw_motion_write(_frl__target=undefined) {
hspeed = 7;
;
vspeed = (- 9);
;
image_speed = 0.75;
;
_frl__target.hspeed += 2;
;
_frl__target.image_speed *= 2;
;
var _frl_before = (hspeed++);
;
var _frl_after = (++ _frl__target.image_speed);
;
scrFRVariableSet(_frl__target, "vspeed_raw", (- 4));
;
return [_frl_before, _frl_after, hspeed, vspeed, image_speed];
;
}

function fr_tests_frontier_gml_source_motion_write(_frl__target=undefined) {
hspeed = (12) * timescale;
;
vspeed = ((- 14)) * timescale;
;
image_speed = (0.5) * timescale;
;
scrFRVariableSet(_frl__target, "hspeed", 16);
;
return [(hspeed / timescale), (vspeed / timescale), (image_speed / timescale), hspeed, vspeed, image_speed];
;
}

function fr_tests_frontier_gml_source_random_vector(_frl__seed=undefined) {
scrFRSourceRandomSetSeed(_frl__seed);
;
var _frl_initial = scrFRSourceRandomGetSeed();
var _frl_first = scrFRSourceRandom(100);
var _frl_afterFirst = scrFRSourceRandomGetSeed();
;
var _frl_integer = scrFRSourceIRandom(9);
var _frl_range = scrFRSourceRandomRange(9, 4);
var _frl_integerRange = scrFRSourceIRandomRange(9, 4);
;
var _frl_selected = scrFRSourceChoose("a", "b", "c");
var _frl_zero = scrFRSourceRandom(0);
var _frl_finalSeed = scrFRSourceRandomGetSeed();
;
return [_frl_initial, _frl_first, _frl_afterFirst, _frl_integer, _frl_range, _frl_integerRange, _frl_selected, _frl_zero, _frl_finalSeed];
;
}

function fr_tests_frontier_gml_source_random_save_restore(_frl__seed=undefined) {
scrFRSourceRandomSetSeed(_frl__seed);
;
var _frl_first = scrFRSourceRandom(100);
var _frl_saved = scrFRSourceRandomGetSeed();
;
repeat (3) {
scrFRSourceRandom(100);
;
scrFRSourceIRandom(9);
;
scrFRSourceChoose("a", "b", "c");
;
}
scrFRSourceRandomSetSeed(_frl_saved);
;
var _frl_next = scrFRSourceRandom(100);
var _frl_finalSeed = scrFRSourceRandomGetSeed();
;
return [_frl_first, _frl_saved, _frl_next, _frl_finalSeed];
;
}

function fr_tests_frontier_gml_source_random_next() {
return scrFRSourceRandom(100);
;
}

function fr_tests_frontier_gml_source_random_seed_only(_frl__seed=undefined) {
scrFRSourceRandomSetSeed(_frl__seed);
;
return scrFRSourceRandomGetSeed();
;
}
