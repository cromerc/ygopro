--Ｓｐ－ヴィジョンウィンド
function c100100128.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100128.cost)
	e1:SetTarget(c100100128.target)
	e1:SetOperation(c100100128.activate)
	c:RegisterEffect(e1)
end
function c100100128.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return tc and tc:IsCanRemoveCounter(tp,0x91,2,REASON_COST) end	
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,2,REASON_COST)	
end
function c100100128.filter(c,e,tp)
	return c:IsLevelBelow(2) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100100128.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100100128.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100100128.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	return true
end
function c100100128.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local dg=Duel.GetMatchingGroup(c100100128.filter,c:GetControler(),LOCATION_GRAVE,0,nil,e,tp) 	
	Duel.Hint(HINT_SELECTMSG,c:GetControler(),HINTMSG_SPSUMMON)
	local tc=dg:Select(c:GetControler(),1,1,nil):GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetOperation(c100100128.desop)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e3:SetCountLimit(1)
		tc:RegisterEffect(e3)
		Duel.SpecialSummonComplete()
	end
end
function c100100128.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
