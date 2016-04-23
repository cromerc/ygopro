--Tomato Paradise
function c511000103.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--token
	local g=Group.CreateGroup()
	g:KeepAlive()
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000103,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511000103.tkcon)
	e2:SetTarget(c511000103.tktg)
	e2:SetOperation(c511000103.tkop)
	e2:SetLabelObject(g)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e3:SetLabelObject(g)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetLabelObject(g)
	c:RegisterEffect(e4)
end
function c511000103.ctfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c511000103.tkcon(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c150.ctfilter,1,nil) and eg:GetFirst():GetSummonType()~=SUMMON_TYPE_SPECIAL+0x20 then
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(eg)
	return true
	else return false end
end
function c511000103.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000103.tkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	if not tc then return end
	local s0=false
	local s1=false
	while tc do
		if tc:IsControler(tp) then s0=true
		else s1=true end
		tc=g:GetNext()
	end
	if s0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000104,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,511000104)
		Duel.SpecialSummonStep(token,0x20,tp,tp,false,false,POS_FACEUP)
	end
	if s1 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000104,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH,1-tp) then
		local token=Duel.CreateToken(1-tp,511000104)
		Duel.SpecialSummonStep(token,0x20,tp,1-tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end