--Rank-Up-Magic Cipher Pursuit
function c511018510.initial_effect(c)
	--Activate
	local re1=Effect.CreateEffect(c)
	re1:SetDescription(aux.Stringid(41201386,0))
	re1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	re1:SetType(EFFECT_TYPE_ACTIVATE)
	re1:SetCode(EVENT_FREE_CHAIN)
	re1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	re1:SetCondition(c511018510.con)
	re1:SetTarget(c511018510.target)
	re1:SetOperation(c511018510.activate)
	c:RegisterEffect(re1)
end

function c511018510.con(e,tp,eg,ep,ev,re,r,rp)
     return Duel.GetLP(tp)-Duel.GetLP(1-tp)>=2000 or Duel.GetLP(1-tp)-Duel.GetLP(tp)>=2000 
end

function c511018510.filter1(c,e,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0xe5)
		and Duel.IsExistingMatchingCard(c511018510.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1)
end
function c511018510.filter2(c,e,tp,mc,rk)
	return c:GetRank()==rk and c:IsSetCard(0xe5) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511018510.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511018510.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c511018510.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511018510.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end

function c511018510.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511018510.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummonStep(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		if sc:IsCode(2530830) or sc:IsCode(6137) then
		local te=Effect.CreateEffect(sc)
		te:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		te:SetCode(EVENT_SPSUMMON_SUCCESS)
		te:SetRange(LOCATION_MZONE)
		te:SetCountLimit(1)
		te:SetCost(sc.descost)
		te:SetTarget(sc.destg)
		te:SetOperation(sc.desop)
		te:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		sc:RegisterEffect(te)
		else
		local te=Effect.CreateEffect(sc)
		te:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		te:SetCode(EVENT_SPSUMMON_SUCCESS)
		te:SetRange(LOCATION_MZONE)
		te:SetCountLimit(1)
		te:SetCondition(sc.condition)
		te:SetCost(sc.cost)
		te:SetTarget(sc.target)
		te:SetOperation(sc.operation)
		te:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		sc:RegisterEffect(te)
		end
		Duel.SpecialSummonComplete()
		sc:CompleteProcedure()
end
end
