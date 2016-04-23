--Dante, Pilgrim of the Burning Abyss
function c5773.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c5773.fcon)
	e1:SetOperation(c5773.fop)
	c:RegisterEffect(e1)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c5773.splimit)
	c:RegisterEffect(e2)
	--cannot target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(c5773.tgvalue)
	c:RegisterEffect(e3)
	--draw
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c5773.drcost)
	e4:SetTarget(c5773.drtg)
	e4:SetOperation(c5773.drop)
	c:RegisterEffect(e4)
	--handes
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOGRAVE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c5773.condition)
	e5:SetTarget(c5773.target)
	e5:SetOperation(c5773.operation)
	c:RegisterEffect(e5)
end
function c5773.fcon(e,g,gc,chkf)
	if g==nil then return true end
	local g1=g:Filter(Card.IsSetCard,nil,0xb1)
	if gc then
		if not gc:IsSetCard(0xb1) then return false end
		g1:Remove(Card.IsCode,nil,gc:GetCode())
		return g1:GetClassCount(Card.GetCode)>=2
	end
	if chkf~=PLAYER_NONE and g1:FilterCount(Card.IsOnField,nil)==0 then return false end
	return g1:GetClassCount(Card.GetCode)>=3
end
function c5773.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local count=3
	local flag=false
	if chkf~=PLAYER_NONE then flag=true end
	local sg=eg:Filter(Card.IsSetCard,nil,0xb1)
	if gc then
		count=2
		flag=false
		sg:Remove(Card.IsCode,nil,gc:GetCode())
	end
	local g=Group.CreateGroup()
	for i=1,count do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local tg=nil
		if flag==true then
			tg=sg:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
		else
			tg=sg:Select(tp,1,1,nil)
		end
		local tc=tg:GetFirst()
		g:AddCard(tc)
		sg:Remove(Card.IsCode,nil,tc:GetCode())
	end
	Duel.SetFusionMaterial(g)
end
function c5773.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c5773.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c5773.cfilter(c)
	return c:IsSetCard(0xb1) and c:IsAbleToGraveAsCost()
end
function c5773.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5773.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c5773.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c5773.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c5773.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c5773.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c5773.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c5773.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
