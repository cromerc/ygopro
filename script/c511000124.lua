--Ancient Key
function c511000124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000124.activate)
	c:RegisterEffect(e1)
	--Add
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(511000124,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511000124.thcost)
	e2:SetTarget(c511000124.thtg)
	e2:SetOperation(c511000124.thop)
	c:RegisterEffect(e2)
	if not c511000124.global_check then
		c511000124.global_check=true
		--register
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_ADJUST)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetOperation(c511000124.operation)
		Duel.RegisterEffect(e3,0)
	end
end
function c511000124.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511000124)==0 then
			local e1=Effect.CreateEffect(e:GetHandler())	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
			e1:SetCode(EVENT_CHANGE_POS)
			e1:SetRange(LOCATION_MZONE)
			e1:SetOperation(c511000124.op)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511000124,RESET_EVENT+0x1fc0000,0,1) 	
		end	
		tc=g:GetNext()
	end		
end
function c511000124.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsHasEffect(511000123) and c:GetFlagEffect(511000125)==0 then
		c:RegisterFlagEffect(511000125,RESET_EVENT+0x1fc0000,0,1)
	else
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(511000123)
		e1:SetRange(LOCATION_MZONE)
		c:RegisterEffect(e1)
	end
end
function c511000124.spfilter(c,e,tp)
	return c:IsCode(511000127) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000124.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not e:GetHandler():IsRelateToEffect(e) then return end
	if ft>2 then ft=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Duel.GetMatchingGroup(c511000124.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(525110,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,ft,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
function c511000124.costfilter(c)
	return c:IsFaceup() and c:IsCode(511000127) and c:IsAbleToGraveAsCost() and c:GetFlagEffect(511000125)>0
end
function c511000124.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000124.costfilter,tp,LOCATION_MZONE,0,2,nil)
		and e:GetHandler():IsAbleToGraveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000124.costfilter,tp,LOCATION_MZONE,0,2,2,nil)
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000124.filter(c)
	return c:IsCode(511000125) and c:IsAbleToHand() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000124.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000124.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c511000124.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000124.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
