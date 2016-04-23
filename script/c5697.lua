--ダブルマジックアームバインド
function c5697.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c5697.cost)
	e1:SetTarget(c5697.target)
	e1:SetOperation(c5697.activate)
	c:RegisterEffect(e1)
end
function c5697.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local rg=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(rg,REASON_COST)
end
function c5697.filter1(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c5697.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c5697.filter,tp,0,LOCATION_MZONE,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c5697.filter,tp,0,LOCATION_MZONE,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,2,0,0)
end
function c5697.filter2(c,e)
	return c:IsFaceup() and c:IsRelateToEffect(e)
end
function c5697.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c5697.filter2,nil,e)
	if not g or g:GetCount()~=2 then return end
	local tc=g:GetFirst()
	while tc do
		if not Duel.GetControl(tc,tp,PHASE_END+RESET_SELF_TURN,1) then
			if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
				Duel.Destroy(tc,REASON_EFFECT)
			end
		end
		tc=g:GetNext()
	end
end
