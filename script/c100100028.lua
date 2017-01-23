--Ｓｐ－いたずら好きな双子悪魔
function c100100028.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100028.cost)
	e1:SetTarget(c100100028.target)
	e1:SetOperation(c100100028.activate)
	c:RegisterEffect(e1)
end
function c100100028.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return Duel.CheckLPCost(tp,1000) and tc and tc:IsCanRemoveCounter(tp,0x91,8,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,8,REASON_COST)	
	Duel.PayLPCost(tp,1000)
end
function c100100028.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,2)
end
function c100100028.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(p,1)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		g:RemoveCard(sg:GetFirst())
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,1-p,HINTMSG_DISCARD)
			sg=g:Select(1-p,1,1,nil)
			Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		end
	end
end
