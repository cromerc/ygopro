--Dark Contract with the Abyss Pendulum
--fixed by MLD
function c511009036.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetHintTiming(TIMING_TOHAND)
	e1:SetTarget(c511009036.target)
	c:RegisterEffect(e1)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2316186,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511009036.thcon)
	e3:SetTarget(c511009036.thtg)
	e3:SetOperation(c511009036.thop)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetDescription(aux.Stringid(9765723,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCountLimit(1)
	e4:SetCondition(c511009036.damcon)
	e4:SetTarget(c511009036.damtg)
	e4:SetOperation(c511009036.damop)
	c:RegisterEffect(e4)
end
function c511009036.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_TO_HAND,true)
	if res then
		if c511009036.thcon(e,tp,teg,tep,tev,tre,tr,trp) and c511009036.thtg(e,tp,teg,tep,tev,tre,tr,trp,0) 
			and Duel.SelectYesNo(tp,aux.Stringid(24348804,0)) then
			e:SetCategory(CATEGORY_DAMAGE)
			e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			c511009036.thtg(e,tp,teg,tep,tev,tre,tr,trp,1)
			e:SetOperation(c511009036.thop)
		else
			e:SetCategory(0)
			e:SetProperty(EFFECT_FLAG_DELAY)
			e:SetOperation(nil)
		end
	end
end
function c511009036.thfilter(c,tp)
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0xaf) and c:GetPreviousControler()==tp and c:IsControler(tp) 
		and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511009036.thcon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511009036.thfilter,nil,tp)
	return g:GetCount()==1
end
function c511009036.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511009036.thfilter,nil,tp)
	local tc=g:GetFirst()
	if chk==0 then return tc and tc:GetDefense()>0 and e:GetHandler():GetFlagEffect(511009036)==0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(tc:GetDefense())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetDefense())
	e:GetHandler():RegisterFlagEffect(511009036,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511009036.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511009036.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511009036.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c511009036.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
