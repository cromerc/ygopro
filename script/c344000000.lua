--ガーベージ·ロード
function c344000000.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c344000000.spcon)
	e1:SetOperation(c344000000.spop)
	c:RegisterEffect(e1)
end
function c344000000.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.CheckLPCost(c:GetControler(),1000)
end
function c344000000.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,1000)
end

