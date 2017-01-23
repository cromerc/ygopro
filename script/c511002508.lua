--風魔神－ヒューガ
function c511002508.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511002508.condition)
	e2:SetTarget(c511002508.target)
	e2:SetOperation(c511002508.activate)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84565800,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCountLimit(1)
	e3:SetOperation(c511002508.negop)
	c:RegisterEffect(e3)
end
function c511002508.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511002508.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002508.cfilter,tp,LOCATION_ONFIELD,0,1,nil,25955164) 
		and Duel.IsExistingMatchingCard(c511002508.cfilter,tp,LOCATION_ONFIELD,0,1,nil,98434877)
end
function c511002508.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511002508.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511002508.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
