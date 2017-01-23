--Number 46: Dragluon (Anime)
function c511001998.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),8,2)
	c:EnableReviveLimit()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_DRAGON))
	c:RegisterEffect(e1)
	--untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c511001998.atkcon)
	e2:SetValue(aux.imval1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(aux.tgval)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetDescription(aux.Stringid(511001998,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c511001998.spcost)
	e4:SetCondition(c511001998.spcon)
	e4:SetTarget(c511001998.sptg)
	e4:SetOperation(c511001998.spop)
	c:RegisterEffect(e4)	
	--control or destroy
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetDescription(aux.Stringid(511001998,1))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511001998.ctcon)
	e5:SetTarget(c511001998.cttg)
	e5:SetOperation(c511001998.ctop)
	c:RegisterEffect(e5)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511001998.indes)
	c:RegisterEffect(e6)
	if not c511001998.global_check then
		c511001998.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001998.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001998.xyz_number=46
function c511001998.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511001998.atkcon(e)
	return Duel.IsExistingMatchingCard(c511001998.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c511001998.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c511001998.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c511001998.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001998.filter(c,e,tp)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511001998.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511001998.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511001998.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001998.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
function c511001998.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()==0 
		and not Duel.IsExistingMatchingCard(c511001998.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c511001998.ctfilter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:IsRace(RACE_DRAGON)
end
function c511001998.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001998.ctfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001998.ctfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511001998.ctfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511001998.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsDestructable() and Duel.SelectYesNo(1-tp,aux.Stringid(80764541,1)) then
			Duel.PayLPCost(1-tp,math.floor(Duel.GetLP(1-tp)/2))
			Duel.Destroy(tc,REASON_EFFECT)
		end
		Duel.GetControl(tc,tp)
	end
end
function c511001998.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,2978414)
	Duel.CreateToken(1-tp,2978414)
end
function c511001998.indes(e,c)
	return not c:IsSetCard(0x48)
end
