#define values(_items)
    var result=[];
    with(_items) array_push(result,self);
    return result;

#define ref_sum(_a,_b,_c)
    return _a+10*_b+100*_c;

#define template(_path)
    return `${_path}sprPopoLaserBrain.png @1(${1+2}:0)`;

#define instance_array(_items)
    with(_items) fr_array_probe+=3;

#define bound_ref
    return script_ref_call(script_ref_create(ref_sum,2,3),4);

#define coroutine
    value=0;
    if(fork()) {
        wait(2);
        value+=10;
        exit;
    }
    value+=1;
    wait(1);
    value+=2;

#define cleanup_coroutine
    wait(2);
    GameCont.fr_cleanup_test=cleanup_value;
    if(fork()) {
        wait(1);
        GameCont.fr_cleanup_fork_test=cleanup_value+1;
        exit;
    }

#define dynamic_case(_value)
    var answer=0;
    switch(_value) {
        case array_get([2,7],0):
        case array_get([2,7],1): answer+=10;
        default: answer+=3; break;
        case 8: answer=88; break;
    }
    return answer;

#define raw_motion_read(_target)
    return [hspeed_raw,vspeed_raw,image_speed_raw,
        hspeed,vspeed,image_speed,
        _target.hspeed_raw,_target.vspeed_raw,_target.image_speed_raw,
        variable_instance_get(_target,"hspeed_raw"),
        variable_instance_get(_target,"vspeed_raw"),
        variable_instance_get(_target,"image_speed_raw"),
        variable_instance_get(_target,"hspeed"),
        variable_instance_get(_target,"vspeed"),
        variable_instance_get(_target,"image_speed"),self,_target];

#define raw_motion_write(_target)
    hspeed_raw=7;
    vspeed_raw=-9;
    image_speed_raw=0.75;
    _target.hspeed_raw+=2;
    _target.image_speed_raw*=2;
    var before=hspeed_raw++;
    var after=++_target.image_speed_raw;
    variable_instance_set(_target,"vspeed_raw",-4);
    return [before,after,hspeed_raw,vspeed_raw,image_speed_raw];

#define source_motion_write(_target)
    hspeed=12;
    vspeed=-14;
    image_speed=0.5;
    variable_instance_set(_target,"hspeed",16);
    return [hspeed,vspeed,image_speed,hspeed_raw,vspeed_raw,image_speed_raw];

#define source_random_vector(_seed)
    random_set_seed(_seed);
    var initial=random_get_seed(),first=random(100),afterFirst=random_get_seed();
    var integer=irandom(9),range=random_range(9,4),integerRange=irandom_range(9,4);
    var selected=choose("a","b","c"),zero=random(0),finalSeed=random_get_seed();
    return [initial,first,afterFirst,integer,range,integerRange,selected,zero,finalSeed];

#define source_random_save_restore(_seed)
    random_set_seed(_seed);
    var first=random(100),saved=random_get_seed();
    repeat(3) {random(100);irandom(9);choose("a","b","c");}
    random_set_seed(saved);
    var next=random(100),finalSeed=random_get_seed();
    return [first,saved,next,finalSeed];

#define source_random_next
    return random(100);

#define source_random_seed_only(_seed)
    random_set_seed(_seed);
    return random_get_seed();
