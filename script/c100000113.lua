--レッドアイズ・バーン
function c100000113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100000113.condition)
	e1:SetTarget(c100000113.target)
	e1:SetOperation(c100000113.activate)
	c:RegisterEffect(e1)
end
function c100000113.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsSetCard(0x3b) and c:IsType(TYPE_MONSTER)
end
function c100000113.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100000113.cfilter,nil,tp)
	return g:GetCount()==1
end
function c100000113.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:Filter(c100000113.cfilter,nil,tp):GetFirst()
	if chk==0 then return true end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,tc:GetAttack())
end
function c100000113.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.HintSelection(Group.FromCards(tc))
		local atk=tc:GetAttack()
		if atk<0 then return end
		Duel.Damage(1-tp,atk,REASON_EFFECT,true)
		Duel.Damage(tp,atk,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
