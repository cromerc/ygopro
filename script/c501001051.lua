---輝竜星－ショウフク
function c501001051.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(c501001051.syctfilter)
							,aux.FilterBoolFunction(c501001051.sycmfilter),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001051,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c501001051.con)
	e1:SetTarget(c501001051.tg)
	e1:SetOperation(c501001051.op)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001051,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_LEAVE_GRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c501001051.target)
	e2:SetOperation(c501001051.operation)
	c:RegisterEffect(e2)
end
function c501001051.syctfilter(c)
	return c:IsType(TYPE_TUNER)
end
function c501001051.sycmfilter(c)
	return not c:IsType(TYPE_TUNER)
	and c:IsSetCard(0x9c)
end
function c501001051.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return c:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c501001051.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local mc=c:GetMaterial()
	local fg=mc:Filter(Card.IsSetCard,nil,0x9c)
	local gs=fg:GetClassCount(Card.GetOriginalAttribute)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,gs,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,LOCATION_ONFIELD)
end
function c501001051.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
end
function c501001051.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and c:GetLevel()<=4
end
function c501001051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct<=0 then
		if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c501001051.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		end
	else
		if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingTarget(c501001051.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		end
	end
	if ct<=0 then
		g1=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_MZONE,0,1,1,nil)
	else
		g1=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,0,1,1,nil)
	end
	local g2=Duel.SelectMatchingCard(tp,c501001051.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	e:SetLabelObject(g2:GetFirst())
	local g=Group.CreateGroup()
	g:Merge(g1)
	g:Merge(g2)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(tp,CATEGORY_DESTROY,g1,1,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,g2,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(tp,CATEGORY_LEAVE_GRAVE,g2,1,tp,LOCATION_GRAVE)
end	
function c501001051.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local tg=Duel.GetChainInfo(tp,CHAININFO_TARGET_CARDS)
	local fg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if fg:GetCount()==2 then
		local tc2=e:GetLabelObject()
		fg:RemoveCard(tc2)
		local tc1=fg:GetFirst()
		if ct<=0 and tc1:GetLocation()~=LOCATION_MZONE then return end
		if tc1:IsDestructable() and tc2:IsCanBeSpecialSummoned(e,0,tp,false,false) then
			if Duel.Destroy(tc1,REASON_EFFECT)~=0 then
				Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end	
