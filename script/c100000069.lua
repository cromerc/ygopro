--暗黒の召喚神
function c100000069.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000069,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c100000069.cost)
	e1:SetTarget(c100000069.target)
	e1:SetOperation(c100000069.operation)
	c:RegisterEffect(e1)	
end
function c100000069.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and not Duel.CheckAttackActivity(tp) end
	Duel.Release(e:GetHandler(),REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c100000069.filter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000069.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsExistingMatchingCard(c100000069.filter,tp,LOCATION_GRAVE,0,1,nil,6007213,e,tp) 
		and Duel.IsExistingMatchingCard(c100000069.filter,tp,LOCATION_GRAVE,0,1,nil,32491822,e,tp) 
		and Duel.IsExistingMatchingCard(c100000069.filter,tp,LOCATION_GRAVE,0,1,nil,69890967,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,LOCATION_GRAVE)
end
function c100000069.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c100000069.filter,tp,LOCATION_GRAVE,0,1,1,nil,6007213,e,tp)	
	local g2=Duel.SelectMatchingCard(tp,c100000069.filter,tp,LOCATION_GRAVE,0,1,1,nil,32491822,e,tp)
	g1:Merge(g2)
	local g3=Duel.SelectMatchingCard(tp,c100000069.filter,tp,LOCATION_GRAVE,0,1,1,nil,69890967,e,tp)
	g1:Merge(g3)
	if g1:GetCount()>2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,false,POS_FACEUP)
	end
end