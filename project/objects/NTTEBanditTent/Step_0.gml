if (lockstep_stop) exit
if (hp<=0) { instance_destroy(); exit }
if (instance_exists(ntte_chest)) {
    ntte_chest.x=x
    ntte_chest.y=y+4
    ntte_chest.xprevious=x
    ntte_chest.yprevious=y+4
}
else if (ntte_chest!=noone) { hp=0; instance_destroy() }
