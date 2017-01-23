--Xyz Cyclone
function c511001790.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c511001790.condition)
	e1:SetTarget(c511001790.target)
	e1:SetOperation(c511001790.activate)
	c:RegisterEffect(e1)
end
function c511001790.condition(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if bc:IsControler(tp) then bc=Duel.GetAttacker() end
	e:SetLabelObject(bc)
	return bc:IsStatus(STATUS_BATTLE_DESTROYED) and bc:GetBattleTarget():IsStatus(STATUS_OPPO_BATTLE)
end
function c511001790.filter(c,e)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP) and (not e or c:IsCanBeEffectTarget(e))
end
function c511001790.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511001790.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c511001790.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local bc=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=Duel.GetMatchingGroup(c511001790.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler(),e)
	local g1=sg:Select(tp,1,1,nil)
	sg:Sub(g1)
	Duel.SetTargetCard(g1)
	if bc:GetOverlayCount()>0 and sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(511001790,0)) then
		local g2=sg:Select(tp,1,1,nil)
		Duel.SetTargetCard(g2)
		g1:Merge(g2)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c511001790.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
