--サイバー・エンジェル－那沙帝弥
--Cyber Angel Nasateiya
--Scripted by Eerie Code
function c99427357.initial_effect(c)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99427357,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c99427357.rctg)
	e1:SetOperation(c99427357.rcop)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99427357,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c99427357.condition)
	e2:SetOperation(c99427357.operation)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(99427357,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c99427357.spcost)
	e3:SetTarget(c99427357.sptg)
	e3:SetOperation(c99427357.spop)
	c:RegisterEffect(e3)
end

function c99427357.rcfil(c)
	return c:IsFaceup()
end
function c99427357.rctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c99427357.rcfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99427357.rcfil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c99427357.rcfil,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetPlayer(tp)
	local atk=math.floor(g:GetFirst():GetAttack()/2)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c99427357.rcop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local atk=math.floor(tc:GetAttack()/2)
	Duel.Recover(p,atk,REASON_EFFECT)
end

function c99427357.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and d:IsType(TYPE_RITUAL)
end
function c99427357.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end

function c99427357.spcfil(c)
	return c:IsSetCard(0x2093) and c:IsAbleToRemoveAsCost()
end
function c99427357.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c99427357.spcfil,tp,LOCATION_GRAVE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c99427357.spcfil,tp,LOCATION_GRAVE,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c99427357.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c99427357.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.GetControl(tc,tp)
	end
end
