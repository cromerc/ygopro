--Ｓｐ－地獄の暴走召喚
function c100100515.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100100515.condition)
	e1:SetCost(c100100515.cost)
	e1:SetTarget(c100100515.target)
	e1:SetOperation(c100100515.activate)
	c:RegisterEffect(e1)
end
function c100100515.cfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c100100515.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100100515.cfilter,nil,tp)
	if g:GetCount()~=1 then return end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:GetAttack()<=1500 and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
end
function c100100515.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return tc and tc:IsCanRemoveCounter(tp,0x91,1,REASON_COST) end	 
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,1,REASON_COST)	
end
function c100100515.filter(c,code,e,tp)
	return c:GetCode()==code and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100100515.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100100515.filter,tp,0x13,0,1,nil,tc:GetCode(),e,tp) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,PLAYER_ALL,0x13)
end
function c100100515.selfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN+TYPE_TRAP)
end
function c100100515.rmfilter(c)
	return c:IsLocation(LOCATION_MZONE) or c:IsLocation(LOCATION_GRAVE)
end
function c100100515.sp(g,tp,pos)
	local sc=g:GetFirst()
	while sc do
		Duel.SpecialSummonStep(sc,0,tp,tp,false,false,pos)
		sc=g:GetNext()
	end
end
function c100100515.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft1=1 end
	local gg=Group.CreateGroup()
	if ft1>0 and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c100100515.filter,tp,0x13,0,nil,tc:GetCode(),e,tp)
		if g:GetCount()<=ft1 then c100100515.sp(g,tp,POS_FACEUP_ATTACK)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local fg=g:Select(tp,ft1,ft1,nil)
			c100100515.sp(fg,tp,POS_FACEUP_ATTACK)
			g:Remove(c100100515.rmfilter,nil)
			gg:Merge(g)
		end
	end
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft2>1 and Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft2=1 end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_FACEUP)
	local sg=Duel.SelectMatchingCard(1-tp,c100100515.selfilter,1-tp,LOCATION_MZONE,0,1,1,nil)
	if sg:GetCount()>0 then
		local g=Duel.GetMatchingGroup(c100100515.filter,1-tp,0x13,0,nil,sg:GetFirst():GetCode(),e,1-tp)
		if g:GetCount()<=ft2 then c100100515.sp(g,1-tp,POS_FACEUP)
		else
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
			local fg=g:Select(1-tp,ft2,ft2,nil)
			c100100515.sp(fg,1-tp,POS_FACEUP)
			g:Remove(c100100515.rmfilter,nil)
			gg:Merge(g)
		end
	end
	Duel.SpecialSummonComplete()
	Duel.SendtoGrave(gg,REASON_EFFECT)
end
