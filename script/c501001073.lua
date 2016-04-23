---影依の原核
function c501001073.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c501001073.sptg)
	e1:SetOperation(c501001073.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001073,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_LEAVE_GRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c501001073.thcon)
	e2:SetTarget(c501001073.thtg)
	e2:SetOperation(c501001073.thop)
	c:RegisterEffect(e2)
end	
function c501001073.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,501001073,0,0x21,1450,1950,9,RACE_SPELLCASTER,ATTRIBUTE_DARK)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c501001073.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,501001073,0,0x21,1450,1950,9,RACE_SPELLCASTER,ATTRIBUTE_DARK) then return end
	if c:IsRelateToEffect(e) then
		c:AddTrapMonsterAttribute(true,ATTRIBUTE_DARK,RACE_SPELLCASTER,9,1450,1950)
		if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
			c:TrapMonsterBlock()
			c:RegisterFlagEffect(501001073,RESET_EVENT+0x1fe0000,0,1)
		end
	end
end
function c501001073.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return c:IsReason(REASON_EFFECT)
	and not c:IsReason(REASON_RETURN)
end
function c501001073.thfilter(c)
	return c:IsAbleToHand()
	and c:GetCode()~=501001073
	and c:IsSetCard(0x9b)
	and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
end
function c501001073.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c501001073.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c501001073.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND,g,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(tp,CATEGORY_LEAVE_GRAVE,g,1,tp,LOCATION_GRAVE)
end	
function c501001073.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
