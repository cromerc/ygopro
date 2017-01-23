--捕食植物ドロソフィルム・ヒドラ
--Predator Plant Drosophyllum Hydra
--Scripted by Eerie Code
function c99913726.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,99913726)
	e1:SetCondition(c99913726.hspcon)
	e1:SetOperation(c99913726.hspop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99913726,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCountLimit(1,99913726+1)
	e2:SetCost(c99913726.atkcost)
	e2:SetTarget(c99913726.atktg)
	e2:SetOperation(c99913726.atkop)
	c:RegisterEffect(e2)
end

function c99913726.hspfilter(c)
	return c:GetCounter(0x1041)>0 and c:IsReleasable()
end
function c99913726.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c99913726.hspfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return false end
	if g:IsExists(Card.IsControler,1,nil,tp) then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	else
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
end
function c99913726.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	local lc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	if lc<0 then
		g=Duel.SelectMatchingCard(tp,c99913726.hspfilter,tp,LOCATION_MZONE,0,1,1,nil)
	else
		g=Duel.SelectMatchingCard(tp,c99913726.hspfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	end
	Duel.Release(g,REASON_COST)
end

function c99913726.atkcfil(c)
	return c:IsSetCard(0x10f3) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c99913726.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99913726.atkcfil,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c99913726.atkcfil,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c99913726.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c99913726.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end