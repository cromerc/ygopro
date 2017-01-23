--Eternal Bond
--  By Shad3

local scard=c511005043

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.fil(c,e,tp)
	return c:IsSetCard(0x55) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end

function scard.ph_fil(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x55)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local n=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if n<1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then n=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.fil,tp,LOCATION_GRAVE,0,n,n,nil,e,tp)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	local ng=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE):Filter(scard.ph_fil,nil)
	local tpn=ng:FilterCount(Card.IsControler,nil,tp)
	local npn=ng:FilterCount(Card.IsControler,nil,1-tp)
	if tpn<=npn or tpn+npn==1 then return end
	if npn>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		tc=ng:Filter(Card.IsControler,nil,1-tp):FilterSelect(tp,Card.IsControlerCanBeChanged,1,1,nil):GetFirst()
		if tc then Duel.GetControl(tc,tp) end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	tc=ng:FilterSelect(tp,Card.IsControler,1,1,nil,tp):GetFirst()
	ng:RemoveCard(tc)
	local val=ng:GetSum(Card.GetAttack)
	if val==0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(val)
	tc:RegisterEffect(e1)
end