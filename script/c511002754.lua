--Spirit Foresight
function c511002754.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c511002754.condition)
	e1:SetTarget(c511002754.target)
	e1:SetOperation(c511002754.activate)
	c:RegisterEffect(e1)
end
function c511002754.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:GetCount()>1 and tp~=ep
end
function c511002754.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:GetCount()-1
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511002754.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Select(tp,1,1,nil)
	local g=eg:Clone()
	g:Sub(sg)
	Duel.NegateSummon(g)
	Duel.Draw(tp,g:GetCount(),REASON_EFFECT)
end
