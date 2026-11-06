var _shake=UberCont.opt_shake,_freeze=UberCont.opt_freeze
UberCont.opt_shake*=0.5; UberCont.opt_freeze=0
event_inherited()
scrNTTEFullPlasmaImpactSmallAfterCreate()
UberCont.opt_shake=_shake; UberCont.opt_freeze=_freeze
