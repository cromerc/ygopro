--Ultimaya Tzolk'in (Anim)
function c511000817.initial_effect(c)
	--dark synchro summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511000817.syncon)
	e1:SetOperation(c511000817.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
	c:SetStatus(STATUS_NO_LEVEL,true)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000817,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SSET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000817.spcon)
	e2:SetTarget(c511000817.sptg)
	e2:SetOperation(c511000817.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_MSET)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_CHANGE_POS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	--check1
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_SSET)
	e6:SetRange(LOCATION_MZONE)
	e6:SetLabel(0)
	e6:SetCondition(c511000817.spcon)
	e6:SetOperation(c511000817.chkop)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_MSET)
	e7:SetLabelObject(e6)
	e7:SetOperation(c511000817.chkop1)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EVENT_CHANGE_POS)
	e8:SetLabelObject(e6)
	e8:SetOperation(c511000817.chkop1)
	c:RegisterEffect(e8)
	local e9=e7:Clone()
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	e9:SetLabelObject(e6)
	e9:SetOperation(c511000817.chkop1)
	c:RegisterEffect(e9)
	--cannot set
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CANNOT_MSET)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(1,0)
	e10:SetCondition(c511000817.setcon1)
	e10:SetTarget(aux.TRUE)
	e10:SetLabelObject(e6)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e11)
	local e11=e10:Clone()
	e11:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e11)
	local e12=e10:Clone()
	e12:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e12:SetTarget(c511000817.sumlimit)
	c:RegisterEffect(e12)
	--reset
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCountLimit(1)
	e13:SetOperation(c511000817.resetop1)
	e13:SetLabelObject(e6)
	c:RegisterEffect(e13)
	--check2
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e14:SetCode(EVENT_SSET)
	e14:SetRange(LOCATION_MZONE)
	e14:SetLabel(0)
	e14:SetCondition(c511000817.chkcon2)
	e14:SetOperation(c511000817.chkop)
	c:RegisterEffect(e14)
	local e15=e14:Clone()
	e15:SetCode(EVENT_MSET)
	e15:SetLabelObject(e14)
	e15:SetOperation(c511000817.chkop1)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EVENT_CHANGE_POS)
	e16:SetLabelObject(e14)
	e16:SetOperation(c511000817.chkop1)
	c:RegisterEffect(e16)
	local e17=e15:Clone()
	e17:SetCode(EVENT_SPSUMMON_SUCCESS)
	e17:SetLabelObject(e14)
	e17:SetOperation(c511000817.chkop1)
	c:RegisterEffect(e17)
	--cannot set
	local e18=Effect.CreateEffect(c)
	e18:SetType(EFFECT_TYPE_FIELD)
	e18:SetCode(EFFECT_CANNOT_MSET)
	e18:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e18:SetRange(LOCATION_MZONE)
	e18:SetTargetRange(0,1)
	e18:SetCondition(c511000817.setcon1)
	e18:SetTarget(aux.TRUE)
	e18:SetLabelObject(e14)
	c:RegisterEffect(e18)
	local e19=e18:Clone()
	e19:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e19)
	local e20=e18:Clone()
	e20:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e20)
	local e21=e18:Clone()
	e21:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e21:SetTarget(c511000817.sumlimit)
	c:RegisterEffect(e21)
	--reset
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e22:SetCode(EVENT_PHASE+PHASE_END)
	e22:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCountLimit(1)
	e22:SetOperation(c511000817.resetop1)
	e22:SetLabelObject(e14)
	c:RegisterEffect(e22)
	--cannot be battle target
	local e23=Effect.CreateEffect(c)
	e23:SetType(EFFECT_TYPE_SINGLE)
	e23:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e23:SetRange(LOCATION_MZONE)
	e23:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e23:SetCondition(c511000817.con)
	e23:SetValue(1)
	c:RegisterEffect(e23)
	--battle des rep
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e24:SetCode(EFFECT_DESTROY_REPLACE)
	e24:SetCountLimit(1)
	e24:SetTarget(c511000817.reptg)
	c:RegisterEffect(e24)
	--change atk and destroy
	local e25=Effect.CreateEffect(c)
	e25:SetDescription(aux.Stringid(511000817,2))
	e25:SetCategory(CATEGORY_DESTROY)
	e25:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e25:SetCode(EVENT_BATTLE_START)
	e25:SetCondition(c511000817.batcon)
	e25:SetTarget(c511000817.battg)
	e25:SetOperation(c511000817.batop)
	c:RegisterEffect(e25)
	--add setcode
	local e26=Effect.CreateEffect(c)
	e26:SetType(EFFECT_TYPE_SINGLE)
	e26:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e26:SetCode(EFFECT_ADD_SETCODE)
	e26:SetValue(0x301)
	c:RegisterEffect(e26)
end
function c511000817.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumpos,POS_FACEDOWN)>0
end
function c511000817.matfilter1(c,syncard)
	return c:IsSetCard(0x301) and c:IsType(TYPE_TUNER) and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c511000817.matfilter2(c,syncard)	
	return c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard) and not c:IsType(TYPE_TUNER)
end
function c511000817.synfilter1(c,g1,g2)
	local tlv=c:GetLevel()	
	if c:GetFlagEffect(100000147)==0 then	
	return g1:IsExists(c511000817.synfilter3,1,nil,tlv)
	else
	return g1:IsExists(c511000817.synfilter3,1,nil,12-tlv)
	end	
end
function c511000817.synfilter3(c,lv)
	return c:GetLevel()==lv
end
function c511000817.syncon(e,c,tuner)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return false end
	local g1=Duel.GetMatchingGroup(c511000817.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local g2=Duel.GetMatchingGroup(c511000817.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	return g2:IsExists(c511000817.synfilter1,1,nil,g1,g2)
end
function c511000817.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local g=Group.CreateGroup()
	local g1=Duel.GetMatchingGroup(c511000817.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local g2=Duel.GetMatchingGroup(c511000817.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local m3=g2:FilterSelect(tp,c511000817.synfilter1,1,1,nil,g1,g2)
	local mt1=m3:GetFirst()
	g:AddCard(mt1)
	local lv1=mt1:GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	if mt1:GetFlagEffect(100000147)==0 then	
		local t1=g1:FilterSelect(tp,c511000817.synfilter3,1,1,nil,lv1)
		g:Merge(t1)
	else 
		local t1=g1:FilterSelect(tp,c511000817.synfilter3,1,1,nil,12-lv1)
		g:Merge(t1)
	end
	c:SetMaterial(g)
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(511000817,0))
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c511000817.cfilter(c,tp)
	return c:IsFacedown() and c:IsControler(tp)
end
function c511000817.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000817.cfilter,1,nil,tp)
end
function c511000817.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000817.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetCode()~=1686814 
		and (c:IsRace(RACE_DRAGON) or c511000817.collection[c:GetCode()] or c:IsSetCard(0x1045) or c:IsSetCard(0x1093)) 
end
c511000817.collection={
	[86240887]=true;[86805855]=true;[70681994]=true;[511000705]=true;[1546123]=true;
	[64599569]=true;[84243274]=true;[91998119]=true;[74157028]=true;[87751584]=true;
	[40418351]=true;[79229522]=true;[2111707]=true;[25119460]=true;[9293977]=true;
	[84058253]=true;[72959823]=true;[100000570]=true;[100000029]=true;[100000621]=true;
	[54752875]=true;[86164529]=true;[21435914]=true;[6021033]=true;[2403771]=true;
	[68084557]=true;[52145422]=true;[62560742]=true;[50321796]=true;[76891401]=true;
	[511001275]=true;[1639384]=true;[77799846]=true;[95992081]=true;[511001273]=true;
	[21970285]=true;[92870717]=true;[51531505]=true;[15146890]=true;[14920218]=true;
	[88935103]=true;[83980492]=true;[19474136]=true;[15146890]=true;[14920218]=true;
}
function c511000817.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c511000817.cfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000817.filter,tp,LOCATION_EXTRA,0,ct,ct,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,ft,ft,nil)
		g:Sub(sg)
		local send=g
		g=sg
		Duel.Destroy(send,REASON_EFFECT)
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000817.chkop(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(1)
end
function c511000817.chkop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end
function c511000817.setcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==1
end
function c511000817.resetop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
function c511000817.chkcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000817.cfilter,1,nil,1-tp)
end
function c511000817.btfilter(c)
	return c:IsRace(RACE_DRAGON) and c:GetSummonLocation()==LOCATION_EXTRA and c:GetCode()~=511000817
end
function c511000817.con(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c511000817.btfilter,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c511000817.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return true
end
function c511000817.batcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not Duel.IsExistingMatchingCard(c511000817.btfilter,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c511000817.battg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetAttackTarget()==c or (Duel.GetAttacker()==c and Duel.GetAttackTarget()~=nil) end
	local g=Duel.GetMatchingGroup(c511000817.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000817.desfilter(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c511000817.batop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	local c=e:GetHandler()
	if tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511000817.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
