--マスク·チェンジ
function c100000365.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000365.target)
	e1:SetOperation(c100000365.activate)
	c:RegisterEffect(e1)
end
function c100000365.tffilter(c)
	local code=c:GetCode()
	return c:IsAbleToRemove()
	and (code==32491822 or code==69890967 or code==6007213)
end
function c100000365.tfilter(c,e,tp)
	return c:IsCode(43378048) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000365.filter(c,code)
	return c:IsCode(code) and c:IsAbleToRemove()
end
function c100000365.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,6007213)
	 and Duel.IsExistingMatchingCard(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,32491822)
	 and Duel.IsExistingMatchingCard(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,69890967) 
	 and Duel.IsExistingMatchingCard(c100000365.tfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
end
function c100000365.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000365.tffilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=sg:Select(tp,1,1,nil)
	sg:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	local ft=2
	local g2=nil
	while ft>0 do
		g2=sg:Select(tp,1,1,nil)
		g1:Merge(g2)
		sg:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
		ft=ft-1
	end
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local sg=Duel.SelectMatchingCard(tp,c100000365.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
        local tc=sg:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(100000365,0))
		e1:SetCategory(CATEGORY_CONTROL)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetRange(LOCATION_MZONE)
		e1:SetOperation(c100000365.copyop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(100000365,1))
		e2:SetCategory(CATEGORY_REMOVE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetTarget(c100000365.destg)
		e2:SetOperation(c100000365.desop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end
function c100000365.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.GetControl(c,1-tp,PHASE_END,1) and not c:IsImmuneToEffect(e) and c:IsAbleToChangeControler() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
function c100000365.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c100000365.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
