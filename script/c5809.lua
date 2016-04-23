--超重武者ヌス－１０
function c5809.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c5809.hspcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c5809.hspcon2)
	e2:SetOperation(c5809.hspop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c5809.descost)
	e3:SetTarget(c5809.destg)
	e3:SetOperation(c5809.desop)
	c:RegisterEffect(e3)
end
function c5809.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c5809.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c5809.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c5809.hspcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c5809.hspop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c5809.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c5809.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x9a)
end
function c5809.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c5809.desfilter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:GetSequence()<5 and c:IsDestructable()
end
function c5809.desfilter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c5809.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local sel=0
		if Duel.IsExistingMatchingCard(c5809.desfilter1,tp,0,LOCATION_SZONE,1,nil) then sel=sel+1 end
		if Duel.IsExistingMatchingCard(c5809.desfilter2,tp,0,LOCATION_SZONE,1,nil) then sel=sel+2 end
		e:SetLabel(sel)
		return sel~=0
	end
	local sel=e:GetLabel()
	if sel==3 then
		sel=Duel.SelectOption(tp,aux.Stringid(5809,0),aux.Stringid(5809,1))+1
	elseif sel==1 then
		Duel.SelectOption(tp,aux.Stringid(5809,0))
	else
		Duel.SelectOption(tp,aux.Stringid(5809,1))
	end
	e:SetLabel(sel)
	if sel==0 then
		local g=Duel.GetMatchingGroup(c5809.desfilter1,tp,0,LOCATION_SZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	else
		local g=Duel.GetMatchingGroup(c5809.desfilter2,tp,0,LOCATION_SZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c5809.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sel=e:GetLabel()
	if sel==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c5809.desfilter1,tp,0,LOCATION_SZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
			local tc=g:GetFirst()
			if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and tc:IsType(TYPE_SPELL+TYPE_TRAP)
				and not tc:IsLocation(LOCATION_HAND+LOCATION_DECK)
				and tc:IsSSetable(true) and Duel.SelectYesNo(tp,aux.Stringid(5809,2)) then
				Duel.SSet(tp,tc)
				Duel.ConfirmCards(1-tp,tc)
			end
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c5809.desfilter2,tp,0,LOCATION_SZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
			local tc=g:GetFirst()
			if (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7))
				and not tc:IsLocation(LOCATION_HAND+LOCATION_DECK) and Duel.SelectYesNo(tp,aux.Stringid(5809,3)) then
				Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			end
		end
	end
end
