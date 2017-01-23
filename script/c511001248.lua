--ゴースト・フリート・サルベージ
function c511001248.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511001248.con)
	e1:SetTarget(c511001248.target)
	e1:SetOperation(c511001248.activate)
	c:RegisterEffect(e1)
end
function c511001248.filter(c,e,tp)
	local og=c:GetMaterial():Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false)
	local ct=0
	if og:GetCount()>2 then
		ct=2
	else
		ct=og:GetCount()
	end
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_XYZ)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>ct
end
function c511001248.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001248.filter,1,nil,e,tp)
end
function c511001248.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c511001248.filter,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511001248.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=eg:Filter(c511001248.filter,nil,e,tp):GetFirst()
	if tc then
		local og=tc:GetMaterial():Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false):Filter(Card.IsLocation,nil,LOCATION_GRAVE)
		local ct=0
		if og:GetCount()>2 then
			ct=2
		else
			ct=og:GetCount()
		end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=ct then return end
		if og:GetCount()>2 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			og=og:Select(tp,2,2,nil)
		end
		og:AddCard(tc)
		local tg=og:GetFirst()
		while tg do
			Duel.SpecialSummonStep(tg,0,tp,tp,false,false,POS_FACEUP)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tg:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_EFFECT)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tg:RegisterEffect(e3)
			tg=og:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
