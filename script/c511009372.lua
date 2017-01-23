--Master Spirit Tech Force - Pendulum Ruler
function c511009372.initial_effect(c)
	c:EnableReviveLimit()
	aux.EnablePendulumAttribute(c,false)
	--fusion material
	aux.AddFusionProcCodeFun(c,511009366,c511009372.fusfilter,1,true,true)
	c:EnableReviveLimit()	
	--cannot be destroyed
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c511009372.atlimit2)
	c:RegisterEffect(e3)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c511009372.distg)
	c:RegisterEffect(e1)
	--effect gain
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(25793414,1))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511009372.eftg)
	e4:SetOperation(c511009372.efop)
	c:RegisterEffect(e4)
	--Set in P.Zone
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c511009372.pztg)
	e3:SetOperation(c511009372.pzop)	
	c:RegisterEffect(e3)
	--to extra
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c511009372.tetg)
	e2:SetOperation(c511009372.teop)
	c:RegisterEffect(e2)
	if not c511009372.global_check then
		c511009372.global_check=true
		local ge=Effect.CreateEffect(c)
		ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge:SetCode(EVENT_CHAINING)
		ge:SetOperation(c511009372.checkop)
		Duel.RegisterEffect(ge,0)
	end
end
--spirit OCG collection
c511009372.collection={
	[67105242]=true; 
	[487395]=true; 
	[92736188]=true; 
	[67957315]=true; 
	[59822133]=true; 
	[2420921]=true; 
	[93599951]=true; 
	[20802187]=true; 
	[16674846]=true; 
	[50418970]=true; 
	[53239672]=true; 
	[92394653]=true; 
}
function c511009372.fusfilter(c)
	return c:IsSetCard(0x414) or c511009372.collection[c:GetCode()]
end

function c511009372.atlimit2(e,c)
	local lv=c:GetLevel()
	return lv<e:GetHandler():GetLevel() and not c:IsImmuneToEffect(e)
end
function c511009372.distg(e,c)
	local lv=c:GetLevel()
	return lv<e:GetHandler():GetLevel() and c:IsType(TYPE_EFFECT)
end
function c511009372.effilter(c)
	return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_PENDULUM) and c:IsPreviousLocation(LOCATION_HAND) and c:IsSetCard(0x1414) and	c:GetFlagEffect(511009366)==0	and c:IsReleasableByEffect()
end
function c511009372.eftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009372.effilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009372.effilter,tp,LOCATION_MZONE,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511009372.effilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c511009372.efop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and Duel.Release(tc,REASON_EFFECT)>0 then
		Duel.MajesticCopy(c,tc)
		Duel.MajesticCopy(c,tc)
		e:GetHandler():RegisterFlagEffect(tc:GetCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		if c:GetFlagEffect(511009372)==0 then
		--double
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCountLimit(1)
		e1:SetTargetRange(1,1)
		e1:SetValue(c511009372.damval)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		c:RegisterFlagEffect(511009372,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c511009372.lol(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

function c511009372.damval(e,re,val,r,rp,rc)
	local c=e:GetHandler()
	if bit.band(r,REASON_EFFECT)>0 and re:GetHandler()==c then return val*2 else return val end
end
function c511009372.pzfilter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7)
end
function c511009372.pztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c511009372.pzfilter,tp,LOCATION_SZONE,0,nil)<2 end
end
function c511009372.pzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end


function c511009372.tetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return not e:GetHandler():IsForbidden() end
end
function c511009372.teop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		-- Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.SendtoExtraP(c,tp,REASON_EFFECT)
	end
end
