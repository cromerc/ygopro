--Strain Endo
function c511002160.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000609,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c511002160.con)
	e1:SetTarget(c511002160.tg)
	e1:SetOperation(c511002160.op)
	c:RegisterEffect(e1)
end
function c511002160.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c511002160.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,Duel.GetLocationCount(tp,LOCATION_MZONE),0,0)
end
function c511002160.spfilter(c,e,tp)
	return (c:IsSetCard(0x216) or c:IsCode(52085072) or c:IsCode(42364257) or c:IsCode(59839761) or c:IsCode(511001326)) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002160.op(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,nil)
	local spg=Duel.GetMatchingGroup(c511002160.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.Destroy(dg,REASON_EFFECT)>0 or dg:GetCount()==0 then
		Duel.BreakEffect()
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 then return end
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=spg:Select(tp,ft,ft,nil)
		if sp:GetCount()>0 then
			ft=ft-sp:GetCount()
			Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
