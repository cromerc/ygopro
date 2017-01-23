--Cards from the Blessed Grass
function c511002217.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002217.target)
	e1:SetOperation(c511002217.activate)
	c:RegisterEffect(e1)
	if not c511002217.global_check then
		c511002217.global_check=true
		c511002217[0]=0
		c511002217[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_HAND)
		ge1:SetOperation(c511002217.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002217.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002217.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c511002217.checkop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=eg:FilterCount(c511002217.cfilter,nil,tp)
	local ct2=eg:FilterCount(c511002217.cfilter,nil,1-tp)
	c511002217[tp]=c511002217[tp]+ct1
	c511002217[1-tp]=c511002217[1-tp]+ct2
end
function c511002217.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511002217[tp]>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=c511002217[tp] 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,28062326,0,0x4011,800,500,1,RACE_PLANT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,c511002217[tp],0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,c511002217[tp],0,0)
end
function c511002217.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<c511002217[tp] then return end
	if ft>c511002217[tp] then ft=c511002217[tp] end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=ft
		and Duel.IsPlayerCanSpecialSummonMonster(tp,28062326,0,0x4011,800,500,1,RACE_PLANT,ATTRIBUTE_EARTH) then
		for i=1,ft do
		local token=Duel.CreateToken(tp,28062326)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
	end
end
function c511002217.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002217[0]=0
	c511002217[1]=0
end
