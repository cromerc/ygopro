--Pendulum Storm
function c511001795.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c511001795.cost)
	e1:SetTarget(c511001795.target)
	e1:SetOperation(c511001795.activate)
	c:RegisterEffect(e1)
end
function c511001795.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lsc1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rsc1=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local lsc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,6)
	local rsc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,7)
	local g=Group.FromCards(lsc1,rsc1,lsc2,rsc2):Filter(Card.IsDestructable,nil)
	local ct=g:FilterCount(Card.IsControler,nil,1-tp)
	local desct=Duel.GetTargetCount(c511001795.filter,tp,0,LOCATION_ONFIELD,e:GetHandler())
	if chk==0 then return g:GetCount()>0 and desct-ct>0 end
	Duel.Destroy(g,REASON_COST)
end
function c511001795.filter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511001795.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c511001795.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c511001795.filter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001795.filter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001795.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
