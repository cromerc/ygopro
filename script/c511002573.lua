--Wave Rebound
function c511002573.initial_effect(c)
	--Activate(effect)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c511002573.condition)
	e4:SetTarget(c511002573.target)
	e4:SetOperation(c511002573.activate)
	c:RegisterEffect(e4)
end
function c511002573.cfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_GRAVE)
end
function c511002573.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	if ex and tg~=nil and tc+tg:FilterCount(c511002573.cfilter,nil)-tg:GetCount()>0 then
		local g=tg:Filter(c511002573.cfilter,nil)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c511002573.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject()
	if chk==0 then return g and g:GetCount()>0 end
	Duel.SetTargetCard(g)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetSum(Card.GetAttack))
end
function c511002573.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Damage(p,tg:GetSum(Card.GetAttack),REASON_EFFECT)
	end
end
