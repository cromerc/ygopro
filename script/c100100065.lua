--Ｓｐ－終焉のカウントダウン
function c100100065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100065.cost)
	e1:SetOperation(c100100065.activate)
	c:RegisterEffect(e1)
end 
function c100100065.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return Duel.CheckLPCost(tp,2000) and tc and tc:IsCanRemoveCounter(tp,0x91,3,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,3,REASON_COST)	
	Duel.PayLPCost(tp,2000)
end
function c100100065.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetFlagEffect(tp,100100065)~=0 then return end
	Duel.RegisterFlagEffect(tp,100100065,0,0,0)
	c:SetTurnCounter(0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetOperation(c100100065.checkop)
	e1:SetCountLimit(1)
	Duel.RegisterEffect(e1,tp)
	c:RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END,0,20)
	c100100065[c]=e1
end
function c100100065.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==20 then
		Duel.Win(tp,0x11)
		c:ResetFlagEffect(1082946)
	end
end
