--ゴーストリック・キョンシー
function c806000020.initial_effect(c)
	--sumlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c806000020.excon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c806000020.target)
	e2:SetOperation(c806000020.operation)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FLIP)
	e3:SetTarget(c806000020.shtg)
	e3:SetOperation(c806000020.shop)
	c:RegisterEffect(e3)
end
function c806000020.exfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8c)
end
function c806000020.excon(e)
	return not Duel.IsExistingMatchingCard(c806000020.exfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c806000020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(806000020)==0 end
	c:RegisterFlagEffect(806000020,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c806000020.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENCE)
	end
end
function c806000020.filter(c,lv)
	return c:GetLevel()<=lv and c:IsSetCard(0x8c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c806000020.ctfilter(c)
	return c:IsSetCard(0x8c) and c:IsFaceup()
end
function c806000020.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=Duel.GetMatchingGroupCount(c806000020.ctfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.GetFlagEffect(tp,806000020)==0 and Duel.IsExistingMatchingCard(c806000020.filter,tp,LOCATION_DECK,0,1,nil,lv) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.RegisterFlagEffect(tp,806000020,RESET_PHASE+PHASE_END,0,1)
end
function c806000020.shop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local lv=Duel.GetMatchingGroupCount(c806000020.ctfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.SelectMatchingCard(tp,c806000020.filter,tp,LOCATION_DECK,0,1,1,nil,lv)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end