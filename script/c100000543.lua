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
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--def 0
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(100000543,1))
	e4:SetCategory(CATEGORY_DEFCHANGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_CHANGE_POS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c100000543.defcon)
	e4:SetOperation(c100000543.defop)
	c:RegisterEffect(e4)
end
function c100000543.spcon(e,c)
	if c==nil then return true end
    return Duel.CheckReleaseGroup(c:GetControler(),Card.IsType,2,nil,TYPE_TOKEN)
end
function c100000543.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,2,2,nil,TYPE_TOKEN)
    Duel.Release(g,REASON_COST)
end
function c100000543.con(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and tg~=e:GetHandler() and tg:IsLevelAbove(10)
end
function c100000543.filter(c)
	return c:IsFaceup() and c:IsAttackPos() and c:IsLevelBelow(9)
end
function c100000543.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000543.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c100000543.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c100000543.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000543.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,0,0,0)
end
function c100000543.deffilter(c)
	return c:IsPreviousPosition(POS_FACEUP_ATTACK) and c:IsPosition(POS_FACEUP_DEFENSE)
end
function c100000543.defcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000543.deffilter,1,e:GetHandler())
end
function c100000543.defop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100000543.deffilter,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		if tc:GetDefense()>0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
