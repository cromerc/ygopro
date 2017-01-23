--Dimension Fusion Destruction
function c100000365.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000365.target)
	e1:SetOperation(c100000365.activate)
	c:RegisterEffect(e1)
end
function c100000365.tfilter(c,e,tp)
	return c:IsCode(43378048) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000365.filter(c,code)
	return c:IsCode(code) and c:IsAbleToRemove()
end
function c100000365.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not Duel.IsExistingMatchingCard(c100000365.tfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) then return false end
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<-2 then return false end
		local g1=Duel.GetMatchingGroup(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,6007213)
		local g2=Duel.GetMatchingGroup(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,32491822)
		local g3=Duel.GetMatchingGroup(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,69890967)
		if g1:GetCount()==0 or g2:GetCount()==0 or g3:GetCount()==0 then return false end
		if ft>0 then return true end
		local f1=g1:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
		local f2=g2:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
		local f3=g3:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
		if ft==-2 then return f1+f2+f3==3
		elseif ft==-1 then return f1+f2+f3>=2
		else return f1+f2+f3>=1 end
	end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,3,0,LOCATION_ONFIELD+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000365.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c100000365.tfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g1=Duel.GetMatchingGroup(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,6007213)
	local g2=Duel.GetMatchingGroup(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,32491822)
	local g3=Duel.GetMatchingGroup(c100000365.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,69890967)
	g1:Merge(g2)
	g1:Merge(g3)
	local g=Group.CreateGroup()
	local tc=nil
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		if ft<=0 then
			tc=g1:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
		else
			tc=g1:Select(tp,1,1,nil):GetFirst()
		end
		g:AddCard(tc)
		g1:Remove(Card.IsCode,nil,tc:GetCode())
		ft=ft+1
	end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local sg=Duel.SelectMatchingCard(tp,c100000365.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
	end
end
