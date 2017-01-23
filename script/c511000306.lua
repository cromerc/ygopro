--Clear World (Anime)
function c511000306.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--adjust
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511000306.adjustop)
	c:RegisterEffect(e3)
	--light
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_PUBLIC)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e4:SetTarget(c511000306.lighttg)
	c:RegisterEffect(e4)
	--dark
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetCondition(c511000306.darkcon1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCondition(c511000306.darkcon2)
	e6:SetTargetRange(0,1)
	c:RegisterEffect(e6)
	--earth
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(74131780,0))
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e7:SetCondition(c511000306.descon)
	e7:SetTarget(c511000306.destg)
	e7:SetOperation(c511000306.desop)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(511000306,1))
	e8:SetCategory(CATEGORY_DESTROY)
	e8:SetCode(EVENT_PHASE+PHASE_END)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetRange(LOCATION_SZONE)
	e8:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e8:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e8:SetCondition(c511000306.descon)
	e8:SetTarget(c511000306.destg2)
	e8:SetOperation(c511000306.desop)
	c:RegisterEffect(e8)
	--water
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(511000306,2))
	e9:SetCategory(CATEGORY_HANDES)
	e9:SetCode(EVENT_PHASE+PHASE_END)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetRange(LOCATION_SZONE)
	e9:SetProperty(EFFECT_FLAG_REPEAT)
	e9:SetCountLimit(1)
	e9:SetCondition(c511000306.hdcon)
	e9:SetTarget(c511000306.hdtg)
	e9:SetOperation(c511000306.hdop)
	c:RegisterEffect(e9)
	--fire
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(511000306,3))
	e10:SetCategory(CATEGORY_DAMAGE)
	e10:SetCode(EVENT_PHASE+PHASE_END)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e10:SetRange(LOCATION_SZONE)
	e10:SetProperty(EFFECT_FLAG_REPEAT)
	e10:SetCountLimit(1)
	e10:SetCondition(c511000306.damcon)
	e10:SetTarget(c511000306.damtg)
	e10:SetOperation(c511000306.damop)
	c:RegisterEffect(e10)
	--wind
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_CANNOT_ACTIVATE)
	e11:SetRange(LOCATION_SZONE)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetTargetRange(1,0)
	e11:SetCondition(c511000306.windcon1)
	e11:SetValue(c511000306.actlimit)
	c:RegisterEffect(e11)
	local e12=e11:Clone()
	e12:SetTargetRange(0,1)
	e12:SetCondition(c511000306.windcon2)
	c:RegisterEffect(e12)
end
c511000306[0]=0
c511000306[1]=0
function c511000306.raccheck(p)
	local rac=0
	for i=0,4 do
		local tc=Duel.GetFieldCard(p,LOCATION_MZONE,i)
		if tc and tc:IsFaceup() then
			rac=bit.bor(rac,tc:GetAttribute())
		end
	end
	c511000306[p]=rac
end
function c511000306.adjustop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerAffectedByEffect(0,511000306) then
		c511000306.raccheck(0)
	else c511000306[0]=0 end
	if not Duel.IsPlayerAffectedByEffect(1,511000306) then
		c511000306.raccheck(1)
	else c511000306[1]=0 end
end
function c511000306.lighttg(e,c)
	return bit.band(c511000306[c:GetControler()],ATTRIBUTE_LIGHT)~=0
end
function c511000306.darkcon1(e)
	return bit.band(c511000306[e:GetHandlerPlayer()],ATTRIBUTE_DARK)~=0
end
function c511000306.darkcon2(e)
	return bit.band(c511000306[1-e:GetHandlerPlayer()],ATTRIBUTE_DARK)~=0
end
function c511000306.descon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(c511000306[Duel.GetTurnPlayer()],ATTRIBUTE_EARTH)~=0 and Duel.GetTurnPlayer()==tp
end
function c511000306.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000306.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000306.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if bit.band(c511000306[Duel.GetTurnPlayer()],ATTRIBUTE_EARTH)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c511000306.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(c511000306[Duel.GetTurnPlayer()],ATTRIBUTE_WATER)~=0
end
function c511000306.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local turnp=Duel.GetTurnPlayer()
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,turnp,1)
end
function c511000306.hdop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if bit.band(c511000306[Duel.GetTurnPlayer()],ATTRIBUTE_WATER)==0 then return end
	Duel.DiscardHand(Duel.GetTurnPlayer(),nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
function c511000306.damcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(c511000306[Duel.GetTurnPlayer()],ATTRIBUTE_FIRE)~=0
end
function c511000306.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local turnp=Duel.GetTurnPlayer()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,turnp,1000)
end
function c511000306.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if bit.band(c511000306[Duel.GetTurnPlayer()],ATTRIBUTE_FIRE)==0 then return end
	Duel.Damage(Duel.GetTurnPlayer(),1000,REASON_EFFECT)
end
function c511000306.windcon1(e)
	return bit.band(c511000306[e:GetHandlerPlayer()],ATTRIBUTE_WIND)~=0
end
function c511000306.windcon2(e)
	return bit.band(c511000306[1-e:GetHandlerPlayer()],ATTRIBUTE_WIND)~=0
end
function c511000306.actlimit(e,te,tp)
	return te:IsHasType(EFFECT_TYPE_ACTIVATE) and te:GetHandler():IsType(TYPE_SPELL)
end
