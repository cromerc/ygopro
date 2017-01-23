--Harmonia Mirror
function c511000622.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetCondition(c511000622.condition)
	e1:SetTarget(c511000773.target)
	e1:SetOperation(c511000622.activate)
	c:RegisterEffect(e1)
end
function c511000622.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:GetSummonType()~=SUMMON_TYPE_SYNCHRO and tc:IsType(TYPE_SYNCHRO) and ep~=tp
end
function c511000773.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsAbleToChangeControler() end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,eg,1,0,0)
end
function c511000622.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
