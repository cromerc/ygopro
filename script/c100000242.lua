--光子圧力界
function c100000242.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--trigger
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000242.damcon)
	e2:SetTarget(c100000242.damtg)
	e2:SetOperation(c100000242.damop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c100000242.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and c100000242.cfilter(tg)
end
function c100000242.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x55)
end
function c100000242.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return true end
	local p=0
	if not Duel.IsExistingMatchingCard(c100000242.cfilter,tp,LOCATION_MZONE,0,1,nil) then
		p=p+1
	end
	if not Duel.IsExistingMatchingCard(c100000242.cfilter,tp,0,LOCATION_MZONE,1,nil) then
		p=p+2
	end
	Duel.SetTargetCard(eg)
	if p==1 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,tc:GetLevel()*100)
	elseif p==2 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetLevel()*100)
	elseif p==3 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,tc:GetLevel()*100)
	end
end
function c100000242.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if not e:GetHandler():IsRelateToEffect(e) or not tc or not tc:IsRelateToEffect(e) then return end
	local p=0
	if not Duel.IsExistingMatchingCard(c100000242.cfilter,tp,LOCATION_MZONE,0,1,nil) then
		p=p+1
	end
	if not Duel.IsExistingMatchingCard(c100000242.cfilter,tp,0,LOCATION_MZONE,1,nil) then
		p=p+2
	end
	if p==1 or p==3 then
		Duel.Damage(tp,tc:GetLevel()*100,REASON_EFFECT)
	end
	if p==2 or p==3 then
		Duel.Damage(1-tp,tc:GetLevel()*100,REASON_EFFECT)
	end
end
