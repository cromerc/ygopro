---Noble Knights of the Round Table
function c502001087.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(502001087,0))
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetLabel(3)
	e2:SetCondition(c502001087.con)
	e2:SetTarget(c502001087.tg1)
	e2:SetOperation(c502001087.op1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(502001087,1))
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetLabel(6)
	e3:SetCondition(c502001087.con)
	e3:SetTarget(c502001087.tg2)
	e3:SetOperation(c502001087.op2)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(502001087,2))
	e4:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetLabel(9)
	e4:SetCondition(c502001087.con)
	e4:SetTarget(c502001087.tg3)
	e4:SetOperation(c502001087.op3)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(502001087,3))
	e5:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetLabel(12)
	e5:SetCondition(c502001087.con)
	e5:SetTarget(c502001087.tg4)
	e5:SetOperation(c502001087.op4)
	c:RegisterEffect(e5)
end
function c502001087.confilter(c)
	return c:IsFaceup()
	and c:IsSetCard(0x107a)
end
function c502001087.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c502001087.confilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	return Duel.GetTurnPlayer()==tp
	and g:GetClassCount(Card.GetCode)>=e:GetLabel()
end
function c502001087.tgfilter(c)
	return c:IsAbleToGrave()
	and c:IsType(TYPE_MONSTER)
	and c:IsSetCard(0x107a)
end
function c502001087.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c502001087.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end	
function c502001087.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c502001087.tgfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end	
function c502001087.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and c:IsType(TYPE_MONSTER)
	and c:IsSetCard(0x107a)
end
function c502001087.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c502001087.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end	
function c502001087.sqfilter(c,tc)
	return c:CheckEquipTarget(tc)
	and c:IsType(TYPE_SPELL)
	and c:IsType(TYPE_EQUIP)
	and c:IsSetCard(0x207a)
end
function c502001087.op2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c502001087.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local g2=Duel.GetMatchingGroup(c502001087.sqfilter,tp,LOCATION_HAND,0,nil,tc)
			if g2:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
				if Duel.SelectYesNo(tp,aux.Stringid(502001087,4)) then
					Duel.BreakEffect()
					local tg2=g2:Select(tp,1,1,nil)
					local tc2=tg2:GetFirst()
					Duel.Equip(tp,tc2,tc)
				end
			end
		end
	end
end	
function c502001087.thfilter(c)
	return c:IsAbleToHand()
	and c:IsType(TYPE_MONSTER)
	and c:IsSetCard(0x107a)
end
function c502001087.tg3(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c502001087.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c502001087.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND,g,1,tp,LOCATION_GRAVE)
end	
function c502001087.op3(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
function c502001087.tg4(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(tp,CATEGORY_DRAW,nil,0,tp,1)
end	
function c502001087.op4(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	Duel.Draw(tp,1,REASON_EFFECT)
end	
