--Beast-borg Medal of the Crimson Chain
function c513000077.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000077.condition1)
	c:RegisterEffect(e1)
	--Activate (sp summon)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c513000077.condition2)
	e2:SetTarget(c513000077.target)
	c:RegisterEffect(e2)
	--trigger
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c513000077.sptg)
	e3:SetOperation(c513000077.spop)
	c:RegisterEffect(e3)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c513000077.descon)
	c:RegisterEffect(e7)
	--card limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetTargetRange(0,1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_SUMMON)
	e5:SetTargetRange(0,1)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EFFECT_CANNOT_ACTIVATE)
	e6:SetTargetRange(0,1)
	e6:SetValue(c513000077.aclimit)
	c:RegisterEffect(e6)
end
function c513000077.condition1(e,tp,eg,ep,ev,re,r,rp)
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS,true)
	return not res or not teg:IsExists(c513000077.tgfilter,1,nil,e,tp)
end
function c513000077.condition2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c513000077.tgfilter,1,nil,e,tp)
end
function c513000077.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c513000077.tgfilter(chkc,e,tp) end
	if chk==0 then return true end
	if c513000077.sptg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		e:SetCategory(CATEGORY_POSITION)
		e:SetOperation(c513000077.spop)
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
		c513000077.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		e:SetOperation(nil)
	end
end
function c513000077.tgfilter(c,e,tp)
	return c:IsControler(1-tp) and c:IsPreviousLocation(LOCATION_EXTRA) and c:IsCanBeEffectTarget(e)
end
function c513000077.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c513000077.tgfilter(chkc,e,tp) end
	if chk==0 then return eg:IsExists(c513000077.tgfilter,1,nil,e,tp) 
		and e:GetHandler():GetFlagEffect(513000077)==0 end
	e:GetHandler():RegisterFlagEffect(513000077,RESET_EVENT+0x1fe0000,0,1)
	local g=eg:FilterSelect(tp,c513000077.tgfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c513000077.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c513000077.rcon)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		tc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e3:SetValue(1)
		tc:RegisterEffect(e3,true)
	end
end
function c513000077.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c513000077.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x20c)
end
function c513000077.descon(e)
	return not Duel.IsExistingMatchingCard(c513000077.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c513000077.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
