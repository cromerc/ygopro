---烈風帝ライザー
function c501001041.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001041,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c501001041.otcon)
	e1:SetOperation(c501001041.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001041,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_LEAVE_GRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c501001041.tdcon)
	e2:SetTarget(c501001041.tdtg)
	e2:SetOperation(c501001041.tdop)
	c:RegisterEffect(e2)
end	
function c501001041.otfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE
end
function c501001041.otcon(e,c)
	if c==nil then return true end
	local g=Duel.GetTributeGroup(c)
	return c:GetLevel()>6
	and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
	and g:IsExists(c501001041.otfilter,1,nil)
end
function c501001041.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetTributeGroup(c)
	local sg=g:FilterSelect(tp,c501001041.otfilter,1,1,nil)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function c501001041.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return c:GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c501001041.tdfilter(c)
	return c:IsAbleToDeck()
end
function c501001041.thfilter(c)
	return c:IsAbleToHand()
end
function c501001041.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c501001041.tdfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	and Duel.IsExistingTarget(c501001041.tdfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
	end
	local g=Group.CreateGroup()
	local g1=Duel.SelectMatchingCard(tp,c501001041.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	local g2=Duel.SelectMatchingCard(tp,c501001041.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	g:Merge(g1)
	g:Merge(g2)
	e:SetLabel(0)
	local mg=c:GetMaterial()
	if mg:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WIND)
	and Duel.IsExistingTarget(c501001041.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		if Duel.SelectYesNo(tp,aux.Stringid(501001041,2)) then
			local g3=Duel.SelectMatchingCard(tp,c501001041.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			g:Merge(g3)
			e:SetLabelObject(g3:GetFirst())
			e:SetLabel(1)
			e:SetCategory(CATEGORY_TODECK+CATEGORY_LEAVE_GRAVE+CATEGORY_TOHAND)
		end
	end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,1,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g2,1,tp,LOCATION_GRAVE)
	if e:GetLabel()==1 then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g3,1,tp,LOCATION_ONFIELD)
	end
end
function c501001041.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local fg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if e:GetLabel()==0 then
		if fg:GetCount()>0 then
			Duel.SendtoDeck(fg,nil,0,REASON_EFFECT)
			if fg:GetCount()==2 then
				local sc1=fg:GetFirst()
				local sc2=fg:GetNext()
				if sc1:GetOwner()==sc2:GetOwner() and sc1:GetLocation()==LOCATION_DECK and sc2:GetLocation()==LOCATION_DECK then
					Duel.SortDecktop(sc1:GetOwner(),sc1:GetOwner(),2)
				end
			end
		end
	else
		local tc=e:GetLabelObject()
		local g=Group.CreateGroup()
		if fg:IsContains(tc) then
			g:AddCard(tc)
			fg:RemoveCard(tc)
		end
		if fg:GetCount()>0 then
			Duel.SendtoDeck(fg,nil,0,REASON_EFFECT)
			if fg:GetCount()==2 then
				local sc1=fg:GetFirst()
				local sc2=fg:GetNext()
				if sc1:GetOwner()==sc2:GetOwner() and sc1:GetLocation()==LOCATION_DECK and sc2:GetLocation()==LOCATION_DECK then
					Duel.SortDecktop(sc1:GetOwner(),sc1:GetOwner(),2)
				end
			end
		end
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
		end
	end
end
