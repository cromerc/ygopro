--Antihope, the God of Despair
function c511001732.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511001732.ttcon)
	e1:SetOperation(c511001732.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e2)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511001732,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,511001732)
	e4:SetCondition(c511001732.thcon)
	e4:SetTarget(c511001732.thtg)
	e4:SetOperation(c511001732.thop)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(0,1)
	e5:SetTarget(c511001732.splimit)
	c:RegisterEffect(e5)
end
function c511001732.ttcon(e,c)
	if c==nil then return true end
	local rg=Duel.GetTributeGroup(c) 
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and rg:GetClassCount(Card.GetLevel)>=3
end
function c511001732.tfilter(c,lv)
	return c:GetLevel()==lv
end
function c511001732.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetTributeGroup(c) 
	local rg=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		if tc then
			rg:AddCard(tc)
			g:Remove(c511001732.tfilter,nil,tc:GetLevel())
		end
	end
	c:SetMaterial(rg)
	Duel.Release(rg,REASON_SUMMON+REASON_MATERIAL)
end
function c511001732.ocfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001732.pcfilter(c)
	return c:IsFaceup() and c:IsCode(52085072)
end
function c511001732.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001732.ocfilter,tp,0,LOCATION_MZONE,1,nil)
		and not Duel.IsExistingMatchingCard(c511001732.pcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001732.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	e:GetHandler():CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511001732.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
function c511001732.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
