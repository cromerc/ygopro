--ワンハンドレッド·アイ·ドラゴン
function c100000150.initial_effect(c)
	--dark synchro summon
	c:EnableReviveLimit()
	c100000150.tuner_filter=function(mc) return mc and mc:IsSetCard(0x301) end
	c100000150.nontuner_filter=function(mc) return true end
	c100000150.minntct=1
	c100000150.maxntct=1
	c100000150.sync=true
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c100000150.syncon)
	e1:SetOperation(c100000150.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)	
	--copy	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)	
	e2:SetOperation(c100000150.operation)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000150,1))
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c100000150.thtg)
	e3:SetOperation(c100000150.thop)
	c:RegisterEffect(e3)
	--actlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetOperation(c100000150.atkop)
	c:RegisterEffect(e4)
	--add setcode
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_ADD_SETCODE)
	e5:SetValue(0x301)
	c:RegisterEffect(e5)
end
function c100000150.tmatfilter(c,syncard)
	return c:IsSetCard(0x301) and c:IsType(TYPE_TUNER) and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c100000150.ntmatfilter(c,syncard)	
	return c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard) and not c:IsType(TYPE_TUNER)
end
function c100000150.synfilter1(c,lv,tuner,syncard)
	local tlv=c:GetSynchroLevel(syncard)
	if c:GetFlagEffect(100000147)==0 then	
		return tuner:IsExists(c100000150.synfilter2,1,nil,lv+tlv,syncard)
	else
		return tuner:IsExists(c100000150.synfilter2,1,nil,lv-tlv,syncard)
	end	
end
function c100000150.synfilter2(c,lv,syncard)
	return c:GetSynchroLevel(syncard)==lv
end
function c100000150.syncon(e,c,tuner)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return false end
	local tuner=Duel.GetMatchingGroup(c100000150.tmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nontuner=Duel.GetMatchingGroup(c100000150.ntmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	return nontuner:IsExists(c100000150.synfilter1,1,nil,8,tuner,c)
end
function c100000150.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local g=Group.CreateGroup()
	local tun=Duel.GetMatchingGroup(c100000150.tmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nont=Duel.GetMatchingGroup(c100000150.ntmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local nontmat=nont:FilterSelect(tp,c100000150.synfilter1,1,1,nil,8,tun,c)
	local mat1=nontmat:GetFirst()
	g:AddCard(mat1)
	local lv1=mat1:GetSynchroLevel(c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local t
	if mat1:GetFlagEffect(100000147)==0 then
		t=tun:FilterSelect(tp,c100000150.synfilter2,1,1,nil,8+lv1,c)
	else
		t=tun:FilterSelect(tp,c100000150.synfilter2,1,1,nil,8-lv1,c)
	end
	g:Merge(t)
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c100000150.filter(c)
	return c:IsSetCard(0xb) and c:IsType(TYPE_MONSTER)
end
function c100000150.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local wg=Duel.GetMatchingGroup(c100000150.filter,c:GetControler(),LOCATION_GRAVE,0,nil)
	local wbc=wg:GetFirst()
	while wbc do
		local code=wbc:GetOriginalCode()
		if c:IsFaceup() and c:GetFlagEffect(code)==0 then
			c:CopyEffect(code,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,1)
			c:RegisterFlagEffect(code,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,1)
		end
		wbc=wg:GetNext()
	end		
end
function c100000150.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c100000150.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c100000150.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c100000150.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c100000150.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c100000150.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
