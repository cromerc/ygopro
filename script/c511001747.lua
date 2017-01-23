--Ultimate Darts Shooter
function c511001747.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001747,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511001747.tg)
	e1:SetOperation(c511001747.op)
	c:RegisterEffect(e1)
	if not c511001747.global_check then
		c511001747.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PHASE+PHASE_END)
		ge1:SetCondition(c511001747.spcon1)
		ge1:SetOperation(c511001747.spop1)
		ge1:SetCountLimit(1)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE+PHASE_END)
		ge2:SetCondition(c511001747.spcon2)
		ge2:SetOperation(c511001747.spop2)
		ge2:SetCountLimit(1)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001747.filter(c,e,tp,tid)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and bit.band(c:GetReason(),0x42)==0x42 and c:GetTurnID()==tid 
		and c:IsSetCard(0x210) and c:GetFlagEffect(511001747)==0
end
function c511001747.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511001747.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c511001747.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local max=99
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then max=1 end
	Duel.SelectTarget(tp,c511001747.filter,tp,LOCATION_GRAVE,0,1,max,nil,e,tp,tid)
end
function c511001747.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()<=0 then return end
	Duel.RegisterFlagEffect(tp,511001747,RESET_PHASE+PHASE_END,0,1)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511001747,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		tc=g:GetNext()
	end
end
function c511001747.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,511001747)>0
end
function c511001747.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(1-tp,511001747)>0
end
function c511001747.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetFlagEffect(511001747)>0
end
function c511001747.spop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001747)
	local sg=Duel.GetMatchingGroup(c511001747.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if sg:GetCount()>ft then return end
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
function c511001747.spop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001747)
	local sg=Duel.GetMatchingGroup(c511001747.spfilter,1-tp,LOCATION_GRAVE,0,nil,e,tp)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft=1 end
	if sg:GetCount()>ft then return end
	Duel.SpecialSummon(sg,0,1-tp,1-tp,false,false,POS_FACEUP)
end
