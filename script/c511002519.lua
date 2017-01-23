--星墜つる地に立つ閃珖
function c511002519.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002519.condition)
	e1:SetTarget(c511002519.target)
	e1:SetOperation(c511002519.activate)
	c:RegisterEffect(e1)
end
function c511002519.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and at:IsOnField() and bit.band(at:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL 
		and Duel.GetAttackTarget()==nil
end
function c511002519.filter(c,e,tp)
	if not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or not c:IsSetCard(0xa3) 
		or c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	if c:IsLocation(LOCATION_HAND) then
		return c:IsControler(tp) or c:IsPublic()
	elseif c:IsLocation(LOCATION_REMOVED) then
		return c:IsFaceup()
	else
		return true
	end
end
function c511002519.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanDraw(tp,1) 
		and Duel.IsExistingMatchingCard(c511002519.filter,tp,0x73,0x32,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x73)
end
function c511002519.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511002519.filter,tp,0x73,0x32,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
