--スフィンクス・アンドロジュネス
function c513000030.initial_effect(c)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87997872,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_HAND+LOCATION_DECK)
	e2:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c513000030.spcon)
	e2:SetCost(c513000030.cost)
	e2:SetTarget(c513000030.sptg)
	e2:SetOperation(c513000030.spop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(87997872,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCost(c513000030.cost)
	e3:SetOperation(c513000030.atkop)
	c:RegisterEffect(e3)
end
function c513000030.cfilter(c,tp,code)
	return c:IsCode(code) and c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY)
end
function c513000030.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c513000030.cfilter,1,nil,tp,15013468)
		and eg:IsExists(c513000030.cfilter,1,nil,tp,51402177)
end
function c513000030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c513000030.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if e:GetHandler():IsLocation(LOCATION_DECK) then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c513000030.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c513000030.afilter(c)
	return c:GetAttack()>0
end
function c513000030.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c513000030.afilter,tp,LOCATION_GRAVE,0,nil)
		local atk=0
		local tg=g:GetFirst()
		while tg do
			atk=atk+tg:GetAttack()
			tg=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		if Duel.GetTurnPlayer()==tp then
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		c:RegisterEffect(e1)
	end
end
