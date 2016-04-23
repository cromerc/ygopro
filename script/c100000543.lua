--超巨大飛行艇ジャイアントヒンデンブルグ
function c100000543.initial_effect(c)
	--special summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c100000543.spcon)
    e1:SetOperation(c100000543.spop)
    c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000543,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c100000543.con)
	e2:SetTarget(c100000543.target)
	e2:SetOperation(c100000543.operation)
	c:RegisterEffect(e2)
end
function c100000543.spcon(e,c)
	if c==nil then return true end
    return Duel.CheckReleaseGroup(c:GetControler(),Card.IsType,2,nil,TYPE_TOKEN)
end
function c100000543.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.SelectReleaseGroup(c:GetControler(),Card.IsType,2,2,nil,TYPE_TOKEN)
    Duel.Release(g,REASON_COST)
end
function c100000543.con(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and tg~=e:GetHandler() and tg:IsLevelAbove(5)
end
function c100000543.filter(c,e,tp)
	return c:IsFaceup() and c:IsAttackPos() and c:IsLevelBelow(9)
end
function c100000543.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000543.filter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c100000543.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c100000543.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000543.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(sg,POS_FACEUP_DEFENCE,0,POS_FACEUP_ATTACK,0)
end
