--Sun Protector
function c511009336.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,	57482479,c511009336.ffilter,1,true,true)
	
		--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62543393,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511009336.target)
	e1:SetOperation(c511009336.operation)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c511009336.atkcon)
	e2:SetValue(aux.imval1)
	c:RegisterEffect(e2)
	
	--Atk down
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24311595,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCondition(c511009336.atkcond)
	e3:SetTarget(c511009336.atktg)
	e3:SetOperation(c511009336.atkop)
	c:RegisterEffect(e3)
	
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(22200403,1))
	e8:SetCategory(CATEGORY_DRAW)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_DESTROYED)
	e8:SetRange(LOCATION_MZONE)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e8:SetCondition(c511009336.atkcond2)
	e8:SetTarget(c511009336.atktg2)
	e8:SetOperation(c511009336.atkop2)
	c:RegisterEffect(e8)
end

function c511009336.ffilter(c)
	return c:IsSetCard(0x52) and c:IsAttribute(ATTRIBUTE_LIGHT)
end


function c511009336.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511009337,0,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511009336.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511009337,0,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_LIGHT) then
		local token=Duel.CreateToken(tp,511009337)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511009336.atkcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil,511009337)
end

-----atk down
function c511009336.atkcond(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	return tc:GetPreviousControler()==tp and  tc:IsCode(511009337) and tc:IsReason(REASON_BATTLE) 
end
function c511009336.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=eg:GetFirst():GetReasonCard()
	if chk==0 then return tg:IsOnField() end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511009336.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
------atk down2
function c511009336.cfilter(c,tp)
	return c:IsCode(511009337) and c:IsReason(REASON_DESTROY) and c:GetReasonPlayer()~=tp
end
function c511009336.atkcond2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009336.cfilter,1,nil,tp) and bit.band(r,REASON_EFFECT)~=0  and re:IsActiveType(TYPE_MONSTER)
end
function c511009336.atktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=re:GetHandler()
	if chk==0 then return tg:IsOnField() end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511009336.atkop2(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end