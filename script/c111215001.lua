--霧の王城
--このカードの「使用していたモンスターカードゾーンに」の部分を再現すると使用不可能にしたゾーンにモンスターが特殊召喚されてしまう為、一部処理を変更しています。
function c111215001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(111215001,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c111215001.spcon)
	e2:SetTarget(c111215001.sptg)
	e2:SetOperation(c111215001.spop)
	c:RegisterEffect(e2)
	--salvage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(111215001,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c111215001.thcon)
	e3:SetCost(c111215001.thcost)
	e3:SetTarget(c111215001.thtg)
	e3:SetOperation(c111215001.thop)
	c:RegisterEffect(e3)
end
function c111215001.cfilter(c,e,tp)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_GRAVE)
		and c:GetPreviousControler()==tp and (not e or c:IsRelateToEffect(e))
end
function c111215001.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c111215001.cfilter,1,nil,nil,tp)
end
function c111215001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=eg:Filter(c111215001.cfilter,nil,nil,tp):GetFirst()
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetLabel(tc:GetPreviousSequence())
	e1:SetOperation(c111215001.disop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(tp,111215001,RESET_EVENT+0x1fe0000,0,1)
end
function c111215001.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c111215001.cfilter,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c111215001.disop(e,tp)
	local c=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if c==0 then return end
	local pseq=e:GetLabel()
	local op
	if pseq==0 then
		op=1
	elseif pseq==1 then
		op=2
	elseif pseq==2 then
		op=4
	elseif pseq==3 then
		op=8
	elseif pseq==4 then
		op=16
	end
	return op
end
function c111215001.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(tp,111215001)>4
end
function c111215001.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local hct=hg:GetCount()
	if chk==0 then return hct>0 and hg:FilterCount(Card.IsAbleToGraveAsCost,nil)==hct and e:GetHandler():IsAbleToGraveAsCost() 
		and Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	hg:AddCard(e:GetHandler())
	Duel.SendtoGrave(hg,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c111215001.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c111215001.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c111215001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c111215001.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c111215001.filter,tp,LOCATION_GRAVE,0,1,4,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c111215001.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
